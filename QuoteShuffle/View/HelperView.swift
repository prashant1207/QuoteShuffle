//
//  HelperView.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 08/10/20.
//

import SwiftUI

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
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: self.gradientA), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
            Rectangle()
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

struct StoryView: View {
    @State var height: CGFloat = 0

    let animation = Animation.easeInOut(duration: 10).repeatForever(autoreverses: true)
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .edgesIgnoringSafeArea(.all)
            .opacity(0.4)
            .frame(height: height, alignment: .center)
            .onAppear {
                withAnimation(animation, {
                    height = UIScreen.main.bounds.height
                })
            }
    }
}

struct FloatingAlert: View {
    @Binding var showingNotice: Bool
    @State var opacity: Double = 0
    var text: String
    var body: some View {
        VStack (alignment: .center, spacing: 0) {
            Image(systemName: "checkmark.circle")
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
