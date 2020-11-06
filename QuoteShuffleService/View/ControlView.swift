//
//  ControlView.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 06/11/20.
//

import SwiftUI

public struct ControlView: View {
    public var onShareTapped: (() -> Void)
    public var onDownloadTapped: (() -> Void)

    public init(onShareTapped: @escaping (() -> Void), onDownloadTapped: @escaping (() -> Void)) {
        self.onShareTapped = onShareTapped
        self.onDownloadTapped = onDownloadTapped
    }

    struct ControlButtonView: View {
        var icon: String
        var text: String
        var onTapped: (() -> Void)

        var body: some View {
            Button(action: {
                onTapped()
            }) {
                HStack(spacing: 10) {
                    Image(systemName: icon)
                    Text(text)
                }
            }
            .foregroundColor(Resource.Shades.buttonForeground)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 8.0)
                            .fill(Resource.Shades.buttonColor))
        }
    }

    public var body: some View {
        VStack {
            VStack {
                ControlButtonView(icon: "square.and.arrow.up", text: "Share") {
                    onShareTapped()
                }

                ControlButtonView(icon: "square.and.arrow.down", text: "Download") {
                    onDownloadTapped()
                }
            }

            QuoteShuffleLogoView()
        }
        .background(Rectangle().fill(Color.clear))
        .padding()
    }
}
