//
//  Document.swift
//  Ex2Documents
//
//  Created by Vladislav Maltsev on 01.01.17.
//  Copyright © 2017 Shedward. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    
    enum DocumentError: Error {
        case wrongDocumentFormat
    }
    
    var todos: [Todo] = []

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
        
        let viewController = windowController.contentViewController as! ViewController
        viewController.document = self
        
        self.addWindowController(windowController)
    }

    override func data(ofType typeName: String) throws -> Data {
        let dict = toDict()
        return try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }

    override func read(from data: Data, ofType typeName: String) throws {
        guard let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw DocumentError.wrongDocumentFormat
        }
        
        try setValue(fromDict: dict)
    }
}

extension Document: MutableDictionaryConvertable {
    private enum Keys: String {
        case todos
    }
    
    func setValue(fromDict dict: [String : Any]) throws {
        let todos = try Document.unwrappedValue(from: dict, for: Keys.todos.rawValue) as [[String: Any]]
        
        self.todos = try todos.map { try Todo(dict: $0) }
    }
    
    func toDict() -> [String : Any] {
        return [
            Keys.todos.rawValue: todos.map { $0.toDict() }
        ]
    }
}

