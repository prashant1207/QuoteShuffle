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
                Text("Tap anywhere to shuffle")
                    .font(.system(size: 18))
                    .foregroundColor(Color.white)
                Text("app allows you to share and save quotes")
                    .font(.system(size: 14))
                    .fontWeight(.thin)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 64, trailing: 16))
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
