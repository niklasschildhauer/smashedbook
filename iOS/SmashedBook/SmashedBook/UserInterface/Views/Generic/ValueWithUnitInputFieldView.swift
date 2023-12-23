//
//  ValueWithUnitInputFieldView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct ValueWithUnitInputFieldView: View {
    // TODO: here is a string not the best choice!
    @Binding var value: String
    let unit: String
    var placeholder: String = ""
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $value)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.trailing)
            TagView(text: unit)
        }
    }
}

struct ValueWithUnitInputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ValueWithUnitInputFieldView(value: .constant(""), unit: "g")
    }
}
