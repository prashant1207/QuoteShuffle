//
//  FloatingAlertView.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 06/11/20.
//

import Foundation
import SwiftUI

struct FloatingAlert: View {
    @Binding var showingNotice: Bool
    @State var opacity: Double = 0
    var icon: String
    var text: String
    
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            Image(systemName: icon)
                .font(.system(size: 64, weight: .regular))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            Text(text)
                .font(.callout)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
        }
        .foregroundColor(Resource.Shades.backgroundColor.opacity(0.75))
        .frame(width: 128, height: 128, alignment: .center)
        .background(Resource.Shades.secondaryBackground.opacity(0.9))
        .cornerRadius(8)
        .opacity(opacity)
        .transition(.scale)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    opacity = 1.0
                }
            })

            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation(Animation.easeOut(duration: 0.5)) {
                    opacity = 0
                }
            })

            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                showingNotice = false
            })
        })
    }
}
