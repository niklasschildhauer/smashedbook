//
//  ValueWithUnitInputFieldView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct ValueWithUnitInputFieldView: View {
    @Binding var value: String
    let unit: String
    var placeholder: String = ""
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $value)
                .multilineTextAlignment(.trailing) 
            TagView(text: unit)
        }
    }
}

struct ValueWithUnitInputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ValueWithUnitInputFieldView(value: .constant("Test"), unit: "g")
    }
}
