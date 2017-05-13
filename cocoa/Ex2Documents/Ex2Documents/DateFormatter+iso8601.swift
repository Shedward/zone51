//
//  DateFormatter+iso8601.swift
//  Ex2Documents
//
//  Created by Vladislav Maltsev on 01.01.17.
//  Copyright © 2017 Shedward. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let iso8602: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        
        return formatter
    }()
}
