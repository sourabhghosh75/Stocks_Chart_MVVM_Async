//
//  Double+Extension.swift
//  Stock Charts
//
//  Created by Sourabh Ghosh on 18/12/21.
//

import Foundation

extension Double {
    
    func formatAsString() -> String {
        return String(format: "%.2f", self)
    }
    func formatAsPercent() -> String {
        return String(format: "%.2f%%", self)
    }
}
