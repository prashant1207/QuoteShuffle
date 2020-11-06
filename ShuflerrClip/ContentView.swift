//
//  ContentView.swift
//  ShuflerrClip
//
//  Created by Prashant Tiwari on 05/11/20.
//

import SwiftUI
import QuoteShuffleService

struct ContentView: View {
    @State var quote: Quote = Quote(quote: "Looks awesome", author: "Show")
    let service = QuoteService()

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                QuoteView(quote: quote)
                Spacer()
            }.onTapGesture {
                refreshQuote()
            }
        }.background(
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                LinearGradient(gradient: Gradient(colors: [.black, .blue]),
                               startPoint: UnitPoint(x: 0, y: 0),
                               endPoint: UnitPoint(x: 0, y: 1))
                    .opacity(0.8)
            }

        )
        .edgesIgnoringSafeArea([.top, .bottom])
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .onAppear {
            refreshQuote()
        }
    }

    func refreshQuote() {
        quote = service.getRandomQuote()
    }
}

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
