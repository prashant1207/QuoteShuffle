//
//  Swipe.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 06/10/20.
//

import Foundation
import SwiftUI

enum Swipe {
    case up
    case down
    case left
    case right
    case unknown

    enum Threshold {
        static let horizontal: CGFloat = 30
        static let vertical: CGFloat = 100
    }

    static func swipeType(_ translation: CGSize) -> Swipe {
        var result: Swipe = .unknown
        if translation.width < 0 && translation.height > -Swipe.Threshold.horizontal && translation.height < Swipe.Threshold.horizontal {
            result = .left
        } else if translation.width > 0 && translation.height > -Swipe.Threshold.horizontal && translation.height < Swipe.Threshold.horizontal {
            result = .right
        } else if translation.height < 0 && translation.width < Swipe.Threshold.vertical && translation.width > -Swipe.Threshold.vertical {
            result = .up
        } else if translation.height > 0 && translation.width < Swipe.Threshold.vertical && translation.width > -Swipe.Threshold.vertical {
            result = .down
        }

        return result
    }
}

enum Tap {
    case top
    case left
    case right
    case bottom
}

