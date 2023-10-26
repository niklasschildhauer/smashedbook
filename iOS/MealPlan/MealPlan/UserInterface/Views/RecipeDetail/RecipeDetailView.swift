//
//  RecipeView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 15.09.23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: RecipeModel
    
    
    private enum CoordinateSpaces {
        case scrollView
    }
    
//    var body: some View {
//        ScrollView {
//            Image("ExamplePicture")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//                .frame(height: UIScreen.main.bounds.size.height)
//            Rectangle()
//                .fill(.black)
//                .edgesIgnoringSafeArea(.vertical)
//                .frame(height: UIScreen.main.bounds.size.height)
//
//            Spacer()
//                .frame(height: 450)
//            ZStack {
//                RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
//                    .fill(.yellow)
//                HStack {
//                    Text("Das ist ein Text")
//                    Spacer()
//                }
//            }
//            .padding(.horizontal, LayoutConstants.safeAreaSpacing)
//            .frame(height: 200)
//        }
//        .background(
//            Image("ExamplePicture")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//        )
//        
//    }
    
    
        var body: some View {
            ScrollView {
                ParallaxHeader(
                    coordinateSpace: CoordinateSpaces.scrollView
                ) {
                    Image("ExamplePicture")
                        .resizable()
                        .scaledToFill()
                }
    
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.white)
                    
                    VStack {
                        VStack {
                            Text(recipe.title)
                            
                            Text("Kalorien: \(recipe.metaInformation.energy ?? 0)")
                            Text("Mahlzeit: \(recipe.metaInformation.meal.rawValue)")
                            Text("Steps: \(recipe.steps.count)")
                        }
                        Spacer()
                            .frame(height: 100)
                        
                        VStack {
                            Text("Kalorien: \(recipe.metaInformation.energy ?? 0)")
                            Text("Mahlzeit: \(recipe.metaInformation.meal.rawValue)")
                            Text("Steps: \(recipe.steps.count)")
                        }
          
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            
            .coordinateSpace(name: CoordinateSpaces.scrollView)
            .edgesIgnoringSafeArea(.top)
        }
}

#Preview {
    RecipeDetailView(recipe: .constant(recipeModelMock))
}

struct ParallaxHeader<Content: View, Space: Hashable>: View {
    private let distanceToScrollWithParallaxEffect: CGFloat = 300
    private let relativeScrollingSpeedForBackground = 0.7
    private let relativeScrollingSpeedForTitle = 0.85
    
    let content: () -> Content
    let coordinateSpace: Space
    
    init(
        coordinateSpace: Space,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.content = content
        self.coordinateSpace = coordinateSpace
    }
    
    var body: some View {
        GeometryReader { proxy in
            let backgroundOffset = offset(for: relativeScrollingSpeedForBackground, proxy: proxy)
            let titleOffset = offset(for: relativeScrollingSpeedForTitle, proxy: proxy)
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
                content()
                    .edgesIgnoringSafeArea(.horizontal)
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height + overScrollingValue
                    )
                    .offset(y: backgroundOffset)
                    .blur(radius: blurRadius)
                
                Text("Lachsrezept")
                    .offset(y: titleOffset)
                    .padding(.top, 120)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .fontDesign(.monospaced)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                    .scaleEffect(textScaleEffect(overScrollingValue), anchor: .top)
            }
        }.frame(height: UIScreen.main.bounds.size.height)
    }
    
    private func offset(for relativeScrollingSpeed: CGFloat, proxy: GeometryProxy) -> CGFloat {
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
