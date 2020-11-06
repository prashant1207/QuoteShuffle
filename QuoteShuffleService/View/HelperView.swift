//
//  HelperView.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 08/10/20.
//

import SwiftUI

public struct AnimatedGradientView: View {
    @State private var gradientA: [Color] = [.blue, .black]
    @State private var gradientB: [Color] = [.blue, .black]

    @State private var firstPlane: Bool = true
    let animation = Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)
    public init() { }
    func setGradient(gradient: [Color]) {
        if firstPlane {
            gradientB = gradient
        }
        else {
            gradientA = gradient
        }
        firstPlane = !firstPlane
    }

    public var body: some View {
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

public struct StoryView: View {
    @State var height: CGFloat = 0

    let animation = Animation.easeInOut(duration: 10).repeatForever(autoreverses: true)
    public var body: some View {
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
