//
//  String+Extensions.swift
//  Trivia
//
//  Created by Josh R on 7/5/21.
//

import Foundation

extension String {

    //Source: https://stackoverflow.com/questions/25607247/how-do-i-decode-html-entities-in-swift
    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }

}
