//
//  GestureView.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 06/11/20.
//

import Foundation
import SwiftUI

struct GestureView: View {
    var onTapAction:((Tap) -> Void)
    var onSwipeAction:((Swipe) -> Void)

    struct OverlayRectangle: View {
        var body: some View {
            Rectangle()
                .fill(Color.black).opacity(0.1)
        }
    }

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            OverlayRectangle()
                .frame(height: 160, alignment: .top)
                .onTapGesture {
                    onTapAction(.top)
                }
            HStack(alignment: .center, spacing: 0) {
                OverlayRectangle()
                    .frame(maxHeight: .infinity, alignment: .leading)
                    .onTapGesture {
                        onTapAction(.left)
                    }
                OverlayRectangle()
                    .frame(maxHeight: .infinity, alignment: .trailing)
                    .onTapGesture {
                        onTapAction(.right)
                    }
            }.gesture(
                DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                    .onEnded({ value in
                        onSwipeAction(Swipe.swipeType(value.translation))
                    })
            )
        }
    }
}
