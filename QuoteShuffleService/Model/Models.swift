//
//  Models.swift
//  QuoteShuffleService
//
//  Created by Prashant Tiwari on 12/10/20.
//

import Foundation

public struct Quote: Codable {
    public let quote, author: String

    public init() {
        quote = ""
        author = ""
    }

    public init(quote: String, author: String) {
        self.quote = quote
        self.author = author
    }

    public func getEncodedString() -> String? {
        guard let data = try? JSONEncoder().encode(self),
              let json = String(data: data, encoding: .utf8) else {
            return nil
        }

        return json.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }

    public static func quote(from encoded: String) -> Quote? {
        guard
            let decoded = encoded.removingPercentEncoding else {
            return nil
        }

        guard
            let data = decoded.data(using: .utf8),
            let quote = try? JSONDecoder().decode(Quote.self, from: data) else {
            return nil
        }

        return quote
    }
}
