//
//  QuoteView.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 08/10/20.
//

import SwiftUI
import QuoteShuffleService

struct QuoteView: View {
    var quote: Quote
    var body: some View {
        VStack{
            Image(systemName: "quote.bubble")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            Text(quote.quote)
                .font(.system(size: 24))
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            Text(quote.author == "" ? "Unknown" : quote.author)
                .fontWeight(.thin)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct QuoteShuffleLogoView: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 58, height: 48, alignment: .center)
        }.padding()
    }
}
