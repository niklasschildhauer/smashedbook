//
//  IconButtonView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.09.23.
//

import SwiftUI

struct IconFilledButtonView: View {
    let icon: Image
    let action: () -> Void
    @State var pressing = false
    
    var body: some View {
        Button(action: {
            HapticFeedbackInteractor.hapticFeedback(for: .buttonClick)
            action()
        }, label: {
            icon
        })
        .buttonStyle(ScaleAnimationFilledButtonStyle(backgroundColor: .accentColor))
    }
}

#Preview {
    HStack {
        IconFilledButtonView(icon: Image(systemName: "trash")) {
            print("Test")
        }
        IconLabelFilledButtonView(title: "Titel") {
            print("Test2")
        }
    }
}
