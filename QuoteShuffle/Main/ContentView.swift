//
//  ContentView.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 28/09/20.
//

import SwiftUI
import QuoteShuffleService

struct ContentView: View {
    @State var quote: Quote = Quote(quote: "Whatever we expect with confidence becomes our own self-fulfilling prophecy.", author: "Brian Tracy")
    @State var showingNotice = false
    @State var startPoint = UnitPoint(x: 1, y: 0)
    @State var endPoint = UnitPoint(x: 1, y: 1)
    @State var bottomSheetShown = false
    @State var welcomeText: String = "Default"
    @State var backgroundImage = Resource.backgroundImage.randomElement() ?? "1"
    @State var quoteFromUrl: Quote? = nil
    @State var height: CGFloat = 0    
    let animation = Animation.easeIn(duration: 1).repeatForever(autoreverses: false)
    let service = QuoteService()
    let configurator = Configurator()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                AnimatedGradientView().opacity(0.65)
                VStack(alignment: HorizontalAlignment.center, spacing: 0) {
                    Rectangle()
                        .fill(Color.black).opacity(0.1)
                        .frame(height: 160, alignment: .top)
                        .gesture(TapGesture().onEnded({ _ in
                            updateTheme()
                        }))
                    HStack(alignment: VerticalAlignment.center, spacing: 0) {
                        Rectangle()
                            .fill(Color.black).opacity(0.1)
                            .frame(maxHeight: .infinity, alignment: .leading)
                            .gesture(TapGesture().onEnded({ _ in
                                refreshQuote(false)
                            }))
                        Rectangle()
                            .fill(Color.black).opacity(0.1)
                            .frame(maxHeight: .infinity, alignment: .trailing)
                            .gesture(TapGesture().onEnded({ _ in
                                refreshQuote(true)
                            }))
                    }.gesture(
                        DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                            .onEnded({ value in
                                let swipeType: Swipe = Swipe.swipeType(value.translation)
                                switch swipeType {
                                case .up:
                                    bottomSheetShown = true
                                default:
                                    break
                                }
                            })
                    )
                }

                VStack {
                    Spacer()
                    QuoteView(quote: quote)
                    Spacer()
                    Image(systemName: "chevron.up")
                        .foregroundColor(Resource.Shades.buttonForeground)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 0))
                }.allowsHitTesting(false)

                if showingNotice {
                    FloatingAlert(showingNotice: $showingNotice, text: "Saved")
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
                VStack {
                    VStack {
                        Button(action: {
                            bottomSheetShown = false
                            shareQuote()
                        }) {
                            HStack(spacing: 10) {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                        }
                        .foregroundColor(Resource.Shades.buttonForeground)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 8.0)
                                        .fill(Resource.Shades.buttonColor))

                        Button(action: {
                            bottomSheetShown = false
                            saveImage()
                        }) {
                            HStack(spacing: 10) {
                                Image(systemName: "square.and.arrow.down")
                                Text("Download")
                            }
                        }
                        .foregroundColor(Resource.Shades.buttonForeground)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 8.0)
                                        .fill(Resource.Shades.buttonColor))
                    }
                    QuoteShuffleLogoView()
                }
                .background(Rectangle().fill(Color.clear))
                .padding()
            }.edgesIgnoringSafeArea(.all)
        }.onAppear {
            refreshQuote(false)
        }.onOpenURL { url in
            guard let parsed = Quote.quote(from: url.absoluteString) else {
                return
            }

            quote = parsed
            quoteFromUrl = parsed
        }
    }

    func updateTheme() {
        backgroundImage = Resource.backgroundImage.randomElement() ?? "1"
    }

    func refreshQuote(_ isForward: Bool) {
        quote = service.getSequentialQuote(isForward: isForward, input: quoteFromUrl)
        quoteFromUrl = nil
    }

    func shareQuote() {
        let av = UIActivityViewController(activityItems: ["\(quote.quote) \n - \(quote.author)"], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }

    func saveImage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            guard let view = UIApplication.shared.windows[0].rootViewController?.view else {
                return
            }
            
            let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
            let image = renderer.image { rendererContext in
                view.layer.render(in: rendererContext.cgContext)
            }

            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

            self.showingNotice = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
