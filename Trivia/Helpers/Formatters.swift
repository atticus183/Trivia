//
//  Formatters.swift
//  Trivia
//
//  Created by Josh R on 7/5/21.
//

import Foundation

struct Formatters {
    static var percentage: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        return formatter
    }()
}
