//
//  DictionaryConvertible.swift
//  Ex2Documents
//
//  Created by Vladislav Maltsev on 01.01.17.
//  Copyright © 2017 Shedward. All rights reserved.
//

import Foundation

enum DictionaryConvertableError: Error {
    case keyNotFound(String)
    case wrongValue(Any, forKey: String)
}

protocol DictionaryConvertable: DictionaryExportable {
    init(dict: [String: Any]) throws
}

protocol MutableDictionaryConvertable: DictionaryExportable {
    func setValue(fromDict dict: [String: Any]) throws
}

protocol DictionaryExportable {
    func toDict() -> [String: Any]
}

extension DictionaryExportable {
    static func unwrappedValue<T>(from dict:[String: Any], for key: String) throws -> T {
        guard let anyValue = dict[key] else { throw DictionaryConvertableError.keyNotFound(key) }
        guard let value = anyValue as? T else { throw DictionaryConvertableError.wrongValue(anyValue, forKey: key) }
        return value
    }
}
