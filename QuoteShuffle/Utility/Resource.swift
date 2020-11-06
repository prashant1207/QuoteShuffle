//
//  Resource.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 05/11/20.
//

import SwiftUI

enum Resource {
    static let backgroundImage = ["1","2","3","4","5"]

    enum Shades {
        static let backgroundColor: Color = Color.fromRGB(28)
        static let secondaryBackground: Color = Color.fromRGB(171)
        static let buttonColor: Color = Color.fromRGB(51)
        static let buttonForeground: Color = Color.fromRGB(219)
    }
}

extension Color {
    static func fromRGB(_ red: Double, _ green: Double, _ blue: Double) -> Color {
        return Color.init(red: red/255, green: green/255, blue: blue/255)
    }

    static func fromRGB(_ value: Double) -> Color {
        return Color.init(red: value/255, green: value/255, blue: value/255)
    }
}
