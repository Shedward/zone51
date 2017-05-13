//
//  VoicesDataSource.swift
//  Ex1Table
//
//  Created by Vladislav Maltsev on 01.01.17.
//  Copyright © 2017 Shedward. All rights reserved.
//

import Cocoa

class VoicesDataSource: NSObject {
    
    fileprivate var voices: [String] = []
    
    override init() {
        super.init()
        refresh()
    }
    
    func refresh() {
        voices = NSSpeechSynthesizer.availableVoices()
    }
    
    func voice(index: Int) -> String {
        return voices[index]
    }
}

extension VoicesDataSource: NSTableViewDataSource {
    
    enum TableColumn: String {
        case name
        case language
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return voices.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        let attributes = NSSpeechSynthesizer.attributes(forVoice: voice(index: row))
        
        guard let columnIdentifier = tableColumn?.identifier else { return nil }
        guard let column = TableColumn(rawValue: columnIdentifier) else { return nil }
        
        switch column  {
        case .name:
            return attributes[NSVoiceName]
        case .language:
            return attributes[NSVoiceLocaleIdentifier]
        }
    }
}
