//
//  Extensions.swift
//  introspec
//
//  Created by Pranjal Bhumij on 30/10/24.
//

import Foundation

extension String {
    func formattedDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        guard let date = isoFormatter.date(from: self) else { return self }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
    }
}


extension String {
    func toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: self)
    }
    
    func toTitle(wordLimit: Int = 5) -> String {
        let words = self.split(separator: " ")
        let limitedWords = words.prefix(wordLimit)
        return limitedWords.joined(separator: " ")
    }
}

extension Date {
    /// Converts a Date to a String based on the specified format
    /// - Parameter format: The desired date format (default is "yyyy-MM-dd")
    /// - Returns: A string representation of the date
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}
