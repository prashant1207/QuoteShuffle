//
//  ContentView.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 28/09/20.
//

import SwiftUI
import QuoteShuffleService

struct ContentView: View {
    @State var quote: Quote = Quote()
    @State var showingAlert: Bool = false
    @State var bottomSheetShown: Bool = false
    @State var backgroundImage: String = "1"
    @State var quoteFromUrl: Quote?

    let viewModel = ContentViewModel()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AnimatedGradientView().opacity(0.65)
                GestureView { tapGesture in
                    switch tapGesture {
                    case .top:
                        updateTheme()
                    case .left, .right:
                        refreshQuote(tapGesture == .right)
                    default:
                        break
                    }
                } onSwipeAction: { swipeGesture in
                    switch swipeGesture {
                    case .up:
                        bottomSheetShown = true
                    default:
                        break
                    }
                }

                VStack {
                    Spacer()
                    QuoteView(quote: quote)
                    Spacer()
                    Image(systemName: "chevron.up")
                        .foregroundColor(Resource.Shades.buttonForeground)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
                }.allowsHitTesting(false)

                if showingAlert {
                    FloatingAlert(showingNotice: $showingAlert, icon: "checkmark.circle", text: "Saved")
                }
            }.background(
                Image(backgroundImage)
                    .resizable()
                    .scaledToFill()
            )
            .edgesIgnoringSafeArea([.top, .bottom])
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .disabled(bottomSheetShown)

            BottomSheetView(isOpen: $bottomSheetShown, maxHeight: 280) {
                ControlView {
                    bottomSheetShown = false
                    shareQuote()
                } onDownloadTapped: {
                    bottomSheetShown = false
                    saveImage()
                }
            }.edgesIgnoringSafeArea(.all)
        }.onAppear {
            onAppear()
        }.onOpenURL { url in
            onOpenUrl(url)
        }
    }

    func onAppear() {
        configure()
    }

    func onOpenUrl(_ url: URL) {
        guard let parsed = Quote.quote(from: url.absoluteString) else {
            return
        }

        quote = parsed
        quoteFromUrl = parsed
    }

    func configure() {
        updateTheme()
        refreshQuote(false)
    }

    func updateTheme() {
        backgroundImage = viewModel.getBackground()
    }

    func refreshQuote(_ isForward: Bool) {
        quote = viewModel.refreshQuote(isForward, quote: quoteFromUrl)
        quoteFromUrl = nil
    }

    func shareQuote() {
        viewModel.share(quote: quote)
    }

    func saveImage() {
        viewModel.saveImage {
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
