//
//  ValueWithUnitInputFieldView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct ValueWithUnitInputFieldView: View {
    @Binding var value: Int?
    let unit: String
    var placeholder: String = ""
    
    var body: some View {
        HStack {
            TextField(placeholder, text: Binding(
                get: {
                    if let value {
                        return String(value)
                    } else {
                        return ""
                    }
                },
                set: {
                    if let newValue = Int($0) {
                        value = newValue
                    }
                }
            ))
            .keyboardType(.numberPad)
            .multilineTextAlignment(.trailing)
            TagView(text: unit)
        }
    }
}

struct ValueWithUnitInputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ValueWithUnitInputFieldView(value: .constant(nil), unit: "g")
    }
}
