//
//  Todo.swift
//  Ex2Documents
//
//  Created by Vladislav Maltsev on 01.01.17.
//  Copyright © 2017 Shedward. All rights reserved.
//

import Foundation

final class Todo: NSObject {
    
    convenience override init() {
        self.init(text: "")
    }
    
    init(text: String, importance: Importance = .normal, creationDate date: Date = Date()) {
        self.text = text
        self.importance = importance
        self.creationDate = date
    }
    
    var text: String
    var importance: Importance
    var creationDate: Date
}

extension Todo: DictionaryConvertable {

    private enum Keys: String {
        case text
        case importance
        case creationDate
    }
    
    convenience init(dict: [String : Any]) throws {
        let text = try Todo.unwrappedValue(from: dict, for: Keys.text.rawValue) as String
        let importance = Importance(rawValue: try Todo.unwrappedValue(from: dict, for: Keys.importance.rawValue))!
        
        let creationDateString = try Todo.unwrappedValue(from: dict, for: Keys.creationDate.rawValue) as String

        guard let creationDate = DateFormatter.iso8602.date(from: creationDateString) else {
            throw DictionaryConvertableError.wrongValue(creationDateString, forKey: Keys.creationDate.rawValue)
        }
        
        self.init(text: text, importance: importance, creationDate: creationDate)
    }
    
    func toDict() -> [String : Any] {
        return [
            Keys.text.rawValue:         text,
            Keys.importance.rawValue:   importance.rawValue,
            Keys.creationDate.rawValue: DateFormatter.iso8602.string(from: creationDate)
        ]
    }
}
