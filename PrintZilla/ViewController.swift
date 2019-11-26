import Cocoa

class ViewController: NSViewController {
     //Sets up Variables for the dropdown menus

    @IBOutlet weak var menuOffice: NSPopUpButton!
    @IBOutlet weak var menuFloor: NSPopUpButton!
    @IBOutlet weak var menuPrinter: NSPopUpButton!
    @IBOutlet weak var buttonInstallPrinter: NSButton!
    
    private var offices: [Office] = []
    private var selectedOffice: Office? { didSet{ officeSelected() }}
    private var selectedFloor: Floor? { didSet{ floorSelected() }}
    private var selectedPrinter: Printer? { didSet{ printerSelected() }}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readOffices()
        setPopupMenus()
    }
     //Creates the function to read the offices.json file and setup the associations
    private func readOffices() {
        guard let path = Bundle.main.path(forResource: "Offices", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let stringData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonArray = stringData as? [[String:Any]] else { return }
        
        for item in jsonArray {
            self.offices += [ Office(data: item) ]
        }
    }
     //Sets up the defaults for the popups
    private func setPopupMenus() {
        self.selectedOffice = nil
        self.selectedFloor = nil
        self.selectedPrinter = nil
        
        menuOffice.removeAllItems()
        menuOffice.addItem(withTitle: "Select...")
        
        menuOffice.menu?.addItem(NSMenuItem.separator())
        menuOffice.addItems(withTitles: self.offices.map{ $0.name })
    }
     //Sets up Variables for the dropdown menu when an office is selected
    private func officeSelected() {
        self.selectedFloor = nil
        self.selectedPrinter = nil
        
        menuFloor.removeAllItems()
        menuFloor.isEnabled = self.selectedOffice != nil
        guard let office = self.selectedOffice else { return }
        menuFloor.addItem(withTitle: "Select...")
        
        menuFloor.menu?.addItem(NSMenuItem.separator())
        menuFloor.addItems(withTitles: office.floors.map{ $0.name })
    }
    //Sets up Variables for the dropdown menu when an Floor is selected
    private func floorSelected() {
        self.selectedPrinter = nil
        
        menuPrinter.removeAllItems()
        menuPrinter.isEnabled = self.selectedFloor != nil
        guard let floor = self.selectedFloor else { return }
        menuPrinter.addItem(withTitle: "Select...")
        
        menuPrinter.menu?.addItem(NSMenuItem.separator())
        menuPrinter.addItems(withTitles: floor.printers.map{ $0.name })
    }
    //Sets up Variables for the dropdown menu when aprinter is selected
    
    private func printerSelected() {
        buttonInstallPrinter.isEnabled = self.selectedPrinter != nil
    }
    //Function to install the printer
    func shell(_ printer: String, ip: String) -> (output: [String], error: [String], exitCode: Int32) {
        
        var output : [String] = []
        var error : [String] = []
        
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", "lpadmin -p \(printer) -D \(printer) -E -v ipp://\(ip)/ipp/print -m everywhere"]

        let outpipe = Pipe()
        task.standardOutput = outpipe
        let errpipe = Pipe()
        task.standardError = errpipe
        task.launch()
        

        let outdata = outpipe.fileHandleForReading.readDataToEndOfFile()
//        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        if var string = String(data: outdata, encoding: .utf8) {
            string = string.trimmingCharacters(in: .newlines)
            output = string.components(separatedBy: "\n")
        }

        let errdata = errpipe.fileHandleForReading.readDataToEndOfFile()
        if var string = String(data: errdata, encoding: .utf8) {
            string = string.trimmingCharacters(in: .newlines)
            error = string.components(separatedBy: "\n")
        }

        task.waitUntilExit()
        let status = task.terminationStatus
        return (output, error, status)
    }
    
    @IBAction func menuOfficeItemSelected(_ sender: NSPopUpButton) {
        guard sender.indexOfSelectedItem != 0 else { return self.selectedOffice = nil }
        self.selectedOffice = self.offices[sender.indexOfSelectedItem - 2]
    }
    
    @IBAction func menuFloorItemSelected(_ sender: NSPopUpButton) {
        precondition(self.selectedOffice != nil, "No office selected. Invalid State Error!")
        guard sender.indexOfSelectedItem != 0 else { return self.selectedFloor = nil }
        self.selectedFloor = self.selectedOffice!.floors[sender.indexOfSelectedItem - 2]
    }
    
    @IBAction func menuPrinterItemSelected(_ sender: NSPopUpButton) {
        precondition(self.selectedFloor != nil, "No floor selected. Invalid State Error!")
        guard sender.indexOfSelectedItem != 0 else { return self.selectedPrinter = nil }
        self.selectedPrinter = self.selectedFloor!.printers[sender.indexOfSelectedItem - 2]
    }
    
    @IBAction func buttonQuitTapped(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
    //error codes for the printer install
    @IBAction func buttonInstallPrinterTapped(_ sender: NSButton) {
        precondition(self.selectedPrinter != nil, "No printer selected. Invalid State Error!")
        let response: (output: [String], error: [String], exitCode: Int32) = shell(self.selectedPrinter!.name, ip: self.selectedPrinter!.ip)
       let alert = NSAlert()
        if response.exitCode == 0
        {
        alert.messageText = "Success!"
        alert.informativeText = "Output: \(response.output.joined(separator: ":"))\n Error: \(response.error.joined(separator: ":"))\n ExitCode: \(response.exitCode)"
        alert.runModal()
        } else
        {
            alert.messageText = "Failed! Please join Mozilla network or Contact Service Desk"
            alert.informativeText = "Output: \(response.output.joined(separator: ":"))\n Error: \(response.error.joined(separator: ":"))\n ExitCode: \(response.exitCode)"
            alert.runModal()
            
        }
       
            
        }
    
}
