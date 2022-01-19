//
//  Date+formatting.swift
//  SportsEvents
//
//  Created by Pedro Alcobia on 19/01/2022.
//

import Foundation

extension Date {
    static let daysPendingFormat = "dd HH:mm.ss"
    
    func dateFormated(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        formatter.shortMonthSymbols = formatter.shortMonthSymbols.map { $0.localizedCapitalized }
        formatter.shortWeekdaySymbols = formatter.shortWeekdaySymbols.map { $0.localizedCapitalized }
        formatter.veryShortMonthSymbols = formatter.veryShortMonthSymbols.map { $0.localizedCapitalized }
        return formatter.string(from: self)
    }
}
