//
//  QuoteService.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 06/10/20.
//

import Foundation

struct QuoteService {
    var quotes: [Quote] = []
    init() {
        guard
            let path = Bundle.main.path(forResource: "quotes", ofType: "json"),
            let data = try? String(contentsOfFile: path).data(using: .utf8) else {
            return
        }

        do {
            quotes = try JSONDecoder().decode([Quote].self, from: data)
        } catch {
            print("error")
        }
    }

    func getRandomQuote() -> Quote {
        var quote = quotes.randomElement() ?? getTestQuote()
        quote = quote.author == "" ? Quote(quote: quote.quote, author: "Unknown") : quote

        return quote
    }

    func getTestQuote() -> Quote {
        let sample = Quote(quote: "Whatever we expect with confidence becomes our own self-fulfilling prophecy.", author: "Brian Tracy")
        return sample
    }
}
