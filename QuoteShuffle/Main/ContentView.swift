//
//  ContentView.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 28/09/20.
//

import SwiftUI

struct ContentView: View {
    @State var quote: Quote = Quote(quote: "Whatever we expect with confidence becomes our own self-fulfilling prophecy.", author: "Brian Tracy")
    @State var gradient = [Color.gray, Color.black]
    @State var startPoint = UnitPoint(x: 1, y: 0)
    @State var endPoint = UnitPoint(x: 1, y: 1)

    let animation = Animation.easeInOut(duration: 3).repeatForever(autoreverses: true)
    let service = QuoteService()

    var body: some View {
        ZStack {
            AnimatedGradientView().opacity(0.65)
            VStack {
                Spacer()
                QuoteView(quote: quote)
                Spacer()
            }
        }
        .background(
            Image("background1")
                .resizable()
                .clipped()
        )
        .edgesIgnoringSafeArea([.top, .bottom])
        .gesture(TapGesture().onEnded({ _ in
            quote = service.getRandomQuote()
        }))
        .onLongPressGesture {
            shareQuote()
        }
        .gesture(
            DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onEnded({ value in
                    let swipeType: Swipe = Swipe.swipeType(value.translation)
                    switch swipeType {
                    case .right, .left:
                        quote = service.getRandomQuote()
                    case .up:
                        shareQuote()
                    default:
                        break
                    }
                }))
    }

    func refreshQuote() {
        quote = service.getRandomQuote()
    }

    func shareQuote() {
        let av = UIActivityViewController(activityItems: ["\(quote.quote) \n - \(quote.author)"], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct QuoteView: View {
    var quote: Quote
    var body: some View {
        VStack{
            Text(quote.quote)
                .font(.system(size: 32))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Text(quote.author)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.white)
        .padding().frame(maxWidth: .infinity, alignment: .leading)

    }
}

struct AnimatedGradientView: View {
    @State private var gradientA: [Color] = [.blue, .black]
    @State private var gradientB: [Color] = [.blue, .black]

    @State private var firstPlane: Bool = true

    let animation = Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)
    func setGradient(gradient: [Color]) {
        if firstPlane {
            gradientB = gradient
        }
        else {
            gradientA = gradient
        }
        firstPlane = !firstPlane
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(gradient: Gradient(colors: self.gradientA), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(gradient: Gradient(colors: self.gradientB), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
                .opacity(self.firstPlane ? 0 : 1)
        }
        .onAppear(perform: {
            withAnimation(animation, {
                self.setGradient(gradient: [Color.black, Color.blue])
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
