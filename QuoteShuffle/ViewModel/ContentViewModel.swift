//
//  ContentViewModel.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 06/11/20.
//

import Foundation
import SwiftUI
import QuoteShuffleService

struct ContentViewModel {
    let service = QuoteService()
    func refreshQuote(_ isForward: Bool, quote: Quote?) -> Quote {
        service.getSequentialQuote(isForward: isForward, input: quote)
    }

    func share(quote: Quote) {
        let av = UIActivityViewController(activityItems: ["\(quote.quote) \n - \(quote.author)"], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }

    func saveImage(onCompleted: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            guard let view = UIApplication.shared.windows[0].rootViewController?.view else {
                return
            }

            let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
            let image = renderer.image { rendererContext in
                view.layer.render(in: rendererContext.cgContext)
            }

            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

            onCompleted()
        }
    }

    func getBackground() -> String {
        return Resource.backgroundImage.randomElement() ?? "1"
    }
}
