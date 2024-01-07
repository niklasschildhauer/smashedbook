//
//  ParallaxHeaderView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 28.10.23.
//

import SwiftUI

struct ParallaxHeader<Background: View, BottomView: View>: View {
    private let distanceToScrollWithParallaxEffect: CGFloat = 300
    private let slowScrollingSpeed = 0.7
    private let noScrollingSpeed = 1.0
    private let relativeScrollingSpeedForTitle = 0.85
    private let metaInformationHeight = 100.0
    private let screenHeight = 600.0
    
    let background: () -> Background
    let bottomView: () -> BottomView
    
    init(
        @ViewBuilder background: @escaping () -> Background,
        @ViewBuilder bottomView: @escaping () -> BottomView
    ) {
        self.background = background
        self.bottomView = bottomView
    }
    
    var body: some View {
            GeometryReader { proxy in
                let backgroundOffset = offset(for: slowScrollingSpeed,
                                              distanceToScrollWithParallaxEffect: distanceToScrollWithParallaxEffect,
                                              proxy: proxy)
                let overScrollingValue = overScrollingValue(for: proxy)
                let scaleEffect: (CGFloat) -> CGSize = { value in
                    let x = value
                    let x_min = 0.0
                    let x_max = 250.0
                    
                    let y_min = 1.0
                    let y_max = 1.1
                    
                    let zoomFactor = ((x - x_min) / (x_max - x_min)) * (y_max - y_min) + y_min
                    return CGSize(width: zoomFactor, height: zoomFactor)
                }
                ZStack(alignment: .top) {
                    background()
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.height + overScrollingValue
                        )
                        .offset(y: backgroundOffset)
                        .clipShape(Rectangle().offset(y: -overScrollingValue))
                    VStack {
                        Spacer()
                        bottomView()
                            .frame(height: metaInformationHeight)
                            .padding(.horizontal, LayoutConstants.safeAreaSpacing)
                            .scaleEffect(scaleEffect(overScrollingValue * 10))
                            .offset(y: -overScrollingValue)
                    }
                }
            }
            .frame(minHeight: screenHeight)
    }
    
    private func offset(for relativeScrollingSpeed: CGFloat, distanceToScrollWithParallaxEffect: CGFloat, proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .scrollView)
        let isScrollingDown: (CGFloat) -> Bool = { $0 < 0 }
        let isParallaxEffectActive: (CGFloat) -> Bool = { $0 < -distanceToScrollWithParallaxEffect }
        let offsetForParallaxEffectAtCurrentScrollPosition: (CGFloat) -> CGFloat = {
            -$0 * relativeScrollingSpeed
        }
        let endOffsetOfParallaxEffect = distanceToScrollWithParallaxEffect * relativeScrollingSpeed
        
        if isScrollingDown(frame.minY) {
            if !isParallaxEffectActive(frame.minY) {
                return offsetForParallaxEffectAtCurrentScrollPosition(frame.minY)
            }
            return endOffsetOfParallaxEffect
        }
        return -frame.minY
    }
    
    private func overScrollingValue(for proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .scrollView)
        return max(0, frame.minY)
    }
}
