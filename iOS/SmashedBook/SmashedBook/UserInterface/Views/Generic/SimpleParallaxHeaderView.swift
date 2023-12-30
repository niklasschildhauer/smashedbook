//
//  ParallaxHeaderView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 28.10.23.
//

import SwiftUI

struct SimpleParallaxHeader: View {
    private let distanceToScrollWithParallaxEffect: CGFloat = 300
    private let slowScrollingSpeed = 0.7
    private let noScrollingSpeed = 1.0
    private let relativeScrollingSpeedForTitle = 0.85
    private let metaInformationHeight = 100.0
    private let screenHeight = 600.0
    
    var body: some View {
        //        GeometryReader { proxy in
        //            let backgroundOffset = offset(for: slowScrollingSpeed,
        //                                          distanceToScrollWithParallaxEffect: distanceToScrollWithParallaxEffect,
        //                                          proxy: proxy)
        //            let titleOffset = offset(for: noScrollingSpeed,
        //                                     distanceToScrollWithParallaxEffect: // TODO: magic number -> should be the title height
        //                                        screenHeight - metaInformationHeight - 220,
        //                                     proxy: proxy)
        //            let metaInformationOffset = offset(for: noScrollingSpeed,
        //                                               distanceToScrollWithParallaxEffect: LayoutConstants.bottomBarHeight,
        //                                               proxy: proxy)
        //            let overScrollingValue = overScrollingValue(for: proxy)
        //            let blurRadius = blurRadius(for: proxy)
        //            let textScaleEffect: (CGFloat) -> CGSize = { value in
        //                let x = value
        //                let x_min = 0.0
        //                let x_max = 250.0
        //
        //                let y_min = 1.0
        //                let y_max = 1.1
        //
        //                let zoomFactor = ((x - x_min) / (x_max - x_min)) * (y_max - y_min) + y_min
        //                return CGSize(width: zoomFactor, height: zoomFactor)
        //            }
        
        ZStack(alignment: .top) {
            GeometryReader { proxy in
                Image("ExamplePicture")
                    .resizable()
                    .scaledToFill()
                //                    .frame(
                //                        width: proxy.size.width,
                //                        height: proxy.size.height //+ overScrollingValue
                //                    )
                //                    .offset(y: backgroundOffset)
                //                    .clipShape(Rectangle().offset(y: -overScrollingValue))
                //                    .blur(radius: blurRadius)
                
                VStack {
                    //                        .offset(y: titleOffset)
                    //                        .padding(.top, 100)
                    //                        .scaleEffect(textScaleEffect(overScrollingValue), anchor: .top)
                    Spacer()
                    Text("Das ist unten")
                    //                        .frame(height: metaInformationHeight)
                    //                        .padding(.horizontal, LayoutConstants.safeAreaSpacing)
                    // TODO: not suitable for iPhone SE -> Maybe make a ParallaxScrollView https://www.youtube.com/watch?v=GQaF3PHwaas
                    //                        .offset(y: -LayoutConstants.bottomBarHeight - 34 + metaInformationOffset - overScrollingValue)
                }
            }
        }
        .frame(height: screenHeight)
    }
    //        .ignoresSafeArea(edges: .top)
    //    }
    
    private func blurRadius(for proxy: GeometryProxy) -> CGFloat {
        let overScrollingValue = overScrollingValue(for: proxy)
        print(overScrollingValue)
        return min(
            overScrollingValue / 20,
            max(10, overScrollingValue / 20)
        )
    }
    
    private func offset(for relativeScrollingSpeed: CGFloat, distanceToScrollWithParallaxEffect: CGFloat, proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .global)
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
        let frame = proxy.frame(in: .global)
        let frame2 = proxy.frame(in: .local)
        print(proxy.safeAreaInsets.top)
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

