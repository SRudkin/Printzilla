import Foundation

struct Office {
    var name: String
    var floors: [Floor]
}

extension Office {
    init(data: [String:Any]) {
        self.name = data["office_name"] as! String
        self.floors = []
        for item in data["floors"] as? [[String:Any]] ?? [] {
            self.floors += [ Floor(data: item) ]
        }
    }
}

struct Floor {
    var name: String
    var printers: [Printer]
}

extension Floor {
    init(data: [String:Any]) {
        self.name = data["name"] as! String
        self.printers = []
        for item in data["printers"] as? [[String:Any]] ?? [] {
            self.printers += [ Printer(data: item) ]
        }
    }
}

struct Printer {
    var name: String
    var ip: String
}

extension Printer {
    init(data: [String:Any]) {
        self.name = data["name"] as! String
        self.ip = data["ip"] as! String
    }
}
