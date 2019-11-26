//
//  QuotesViewController.swift
//  Printer3
//
//  Created by SFO Loaner on 11/14/19.
//  Copyright © 2019 SFO Loaner. All rights reserved.
//

import Cocoa

class QuotesViewController: NSViewController {
    let quotes = Quote.all
    
    var currentQuoteIndex: Int = 0 {
        didSet {
            updateQuote()
        }
    }
@IBOutlet var textLabel: NSTextField!
    
    
    
    
}
// MARK: Actions

extension QuotesViewController {
    @IBAction func previous(_ sender: NSButton) {
        currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count
    }
    
    @IBAction func next(_ sender: NSButton) {
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
    }
    
    @IBAction func quit(_ sender: NSButton) {
        NSApplication.shared.terminate(sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuoteIndex = 0
    }
    
    func updateQuote() {
        textLabel.stringValue = String(describing: quotes[currentQuoteIndex])
    }



}
