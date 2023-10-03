//
//  BottomNavigationBarViewModifier.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.09.23.
//

import SwiftUI


// TODO
struct BottomNavigationBarView<Content: View>: View {
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        content()
            .safeAreaPadding(.bottom, LayoutConstants.bottomBarHeight)
    }
}

#Preview {
    BottomNavigationBarView {
        Text("Test")
    }
}
