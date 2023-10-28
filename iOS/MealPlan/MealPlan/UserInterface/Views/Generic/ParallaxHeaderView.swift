//
//  ParallaxHeaderView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 28.10.23.
//

import SwiftUI

struct ParallaxHeader<Background: View, MetaInformation: View, Space: Hashable>: View {
    private let distanceToScrollWithParallaxEffect: CGFloat = 300
    private let relativeScrollingSpeedForBackground = 0.7
    private let relativeScrollingSpeedForTitle = 0.85
    private let metaInformationHeight = 100.0
    
    let background: () -> Background
    let metaInformation: () -> MetaInformation
    let coordinateSpace: Space
    
    init(
        coordinateSpace: Space,
        @ViewBuilder background: @escaping () -> Background,
        @ViewBuilder metaInfo: @escaping () -> MetaInformation
    ) {
        self.background = background
        self.coordinateSpace = coordinateSpace
        self.metaInformation = metaInfo
    }
    
    var body: some View {
        GeometryReader { proxy in
            let backgroundOffset = offset(for: relativeScrollingSpeedForBackground, distanceToScrollWithParallaxEffect: distanceToScrollWithParallaxEffect, proxy: proxy)
            let titleOffset = offset(for: 1, distanceToScrollWithParallaxEffect: distanceToScrollWithParallaxEffect, proxy: proxy)
            let metaInformationOffset = offset(for: 1, distanceToScrollWithParallaxEffect: LayoutConstants.bottomBarHeight,
                                               proxy: proxy)
            let overScrollingValue = overScrollingValue(for: proxy)
            let blurRadius = min(
                overScrollingValue / 20,
                max(10, overScrollingValue / 20)
            )
            let textScaleEffect: (CGFloat) -> CGSize = { value in
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
                    .edgesIgnoringSafeArea(.horizontal)
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height + overScrollingValue
                    )
                    .offset(y: backgroundOffset)
                    .blur(radius: blurRadius)
                
                VStack {
                    Text("Lachsrezept")
                        .offset(y: titleOffset)
                        .padding(.top, 120)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .fontDesign(.monospaced)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                        .scaleEffect(textScaleEffect(overScrollingValue), anchor: .top)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                            .fill(.thinMaterial)
                        metaInformation()
                    }
                    .frame(height: metaInformationHeight)
                    .padding(.horizontal, LayoutConstants.safeAreaSpacing)
                    // TODO: not suitable for iPhone SE -> Maybe make a ParallaxScrollView https://www.youtube.com/watch?v=GQaF3PHwaas
                    .offset(y: -LayoutConstants.bottomBarHeight - 34 + metaInformationOffset - overScrollingValue)
                }
            }
        }
        .frame(minHeight: UIScreen.main.bounds.height)
    }
    
    private func offset(for relativeScrollingSpeed: CGFloat, distanceToScrollWithParallaxEffect: CGFloat, proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .named(coordinateSpace))
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
        let frame = proxy.frame(in: .named(coordinateSpace))
        return max(0, frame.minY)
    }
}


//struct ContentView: View {
//    @State private var location = CGPoint.zero
//
//
//    var body: some View {
//        VStack {
//            Color.red.frame(width: 100, height: 100)
//                .overlay(circle)
//            Text("Location: \(Int(location.x)), \(Int(location.y))")
//        }
//        .coordinateSpace(name: "stack")
//    }
//
//
//    var circle: some View {
//        Circle()
//            .frame(width: 25, height: 25)
//            .gesture(drag)
//            .padding(5)
//    }
//
//
//    var drag: some Gesture {
//        DragGesture(coordinateSpace: .named("stack"))
//            .onChanged { info in location = info.location }
//    }
//}
//
//#Preview(body: {
//    ContentView()
//})
//

