//
//  IconButtonView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.09.23.
//

import SwiftUI

struct IconButtonView: View {
    let icon: Image
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            icon
        })
    }
}

struct IconButtonView_Previews: PreviewProvider {
    static var previews: some View {
        IconButtonView(icon: Image(systemName: "plus"), action: {
            print("Test")
        })
    }
}
