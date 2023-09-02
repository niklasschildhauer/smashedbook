//
//  AddDividerViewModifier.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct DeleteSwipeGestureViewModifier: ViewModifier {
    @State private var offset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset, y: 0)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.width < 0 {
                            self.offset = value.translation.width
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            if -value.translation.width > 100 {
                                // Perform action when swipe is completed
                                self.offset = -200 // Move the view out of the screen
                            } else {
                                self.offset = 0 // Reset the offset
                            }
                        }
                    }
            )
    }
}

extension ListCellWrapperView {
    func deleteSwipeGesture() -> some View {
        self.modifier(DeleteSwipeGestureViewModifier())
    }
}
