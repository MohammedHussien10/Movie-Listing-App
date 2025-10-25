//
//  DateFormater.swift
//  Movie-Listing-App
//
//

import Foundation

extension String{
    
    var onlyYear : String{
    
    let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy"
            return outputFormatter.string(from: date)
        } else {
            return "N/A"
        }
    }
    
    
}
