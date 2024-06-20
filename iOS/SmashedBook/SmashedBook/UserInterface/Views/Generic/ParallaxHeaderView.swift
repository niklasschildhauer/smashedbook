//
//  ParallaxHeaderView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 28.10.23.
//

import SwiftUI

struct ParallaxHeader<Background: View, BottomView: View>: View {
    private let distanceToScrollWithParallaxEffect: CGFloat = 200
    private let slowScrollingSpeed = 0.7
    private let headerHeight = 600.0
    
    @ViewBuilder var background: Background
    @ViewBuilder var bottomView: BottomView
        
    var body: some View {
            GeometryReader { proxy in
                let backgroundOffset = offset(for: slowScrollingSpeed,
                                              distanceToScrollWithParallaxEffect: distanceToScrollWithParallaxEffect,
                                              proxy: proxy)
                let overScrollingValue = overScrollingValue(for: proxy)

                ZStack(alignment: .top) {
                    background
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.height + overScrollingValue
                        )
                        .offset(y: backgroundOffset)
                        .clipShape(
                            Rectangle()
                                .offset(y: -overScrollingValue)
                        )
                    VStack {
                        Spacer()
                        bottomView
                            .offset(y: -overScrollingValue)
                    }
                }
            }
            .listRowInsets(.init(top: -5, leading: 0, bottom: 0, trailing: 0))
            .frame(minHeight: headerHeight)
    }
    
    private func offset(for relativeScrollingSpeed: CGFloat, distanceToScrollWithParallaxEffect: CGFloat, proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .scrollView)
        let isScrollingDown: (CGFloat) -> Bool = { $0 < 0 }
        let isParallaxEffectActive: (CGFloat) -> Bool = { $0 < -distanceToScrollWithParallaxEffect }
        let offsetForParallaxEffectAtCurrentScrollPosition: (CGFloat) -> CGFloat = {
            -$0 * relativeScrollingSpeed
        }
        let endOffsetOfParallaxEffect = distanceToScrollWithParallaxEffect * relativeScrollingSpeed
        let relativFrameHeight = (proxy.frame(in: .local).height - proxy.frame(in: .global).height)
        let minY = frame.minY - relativFrameHeight
                
        if isScrollingDown(minY) {
            if !isParallaxEffectActive(minY) {
                return offsetForParallaxEffectAtCurrentScrollPosition(minY)
            }
            return endOffsetOfParallaxEffect
        }
        return -minY
    }
    
    private func overScrollingValue(for proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .scrollView)
        let relativFrameHeight = proxy.frame(in: .local).height - proxy.frame(in: .global).height
        let minY = frame.minY - relativFrameHeight

        return max(0, minY)
    }
    
    private func  scaleEffect(_ value: CGFloat) -> CGSize {
        let x = value
        let x_min = 0.0
        let x_max = 250.0
        
        let y_min = 1.0
        let y_max = 1.1
        
        let zoomFactor = ((x - x_min) / (x_max - x_min)) * (y_max - y_min) + y_min
        return CGSize(width: zoomFactor, height: zoomFactor)
    }
}
