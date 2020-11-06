//
//  GestureView.swift
//  QuoteShuffle
//
//  Created by Prashant Tiwari on 06/11/20.
//

import SwiftUI

public struct GestureView: View {
    public var onTapAction:((Tap) -> Void)
    public var onSwipeAction:((Swipe) -> Void)

    public init(onTapAction: @escaping ((Tap) -> Void), onSwipeAction: @escaping ((Swipe) -> Void)) {
        self.onTapAction = onTapAction
        self.onSwipeAction = onSwipeAction
    }

    struct OverlayRectangle: View {
        var body: some View {
            Rectangle()
                .fill(Color.black).opacity(0.1)
        }
    }

    public var body: some View {
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
