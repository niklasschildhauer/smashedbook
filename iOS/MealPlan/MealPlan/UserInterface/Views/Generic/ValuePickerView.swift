//
//  ValuePickerView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

protocol PickerValue: CaseIterable, Identifiable, Hashable {
    var rawValue: String { get }
}

struct ValuePickerView<Value: PickerValue>: View {
    var values: [Value]
    @Binding var selectedFlavor: Value
    
    var body: some View {
        Picker("", selection: $selectedFlavor) {
            ForEach(values, id: \.self) { flavor in
                TagView(text: flavor.rawValue.capitalized)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct ValuePickerView_Previews: PreviewProvider {
    
    enum Flavor: String, PickerValue {
        case chocolate, vanilla, strawberry
        var id: Self { self }
    }
    
    static var previews: some View {
        @State var test = Flavor.vanilla
        
        ValuePickerView<Flavor>(values: Flavor.allCases, selectedFlavor: $test)
    }
}
