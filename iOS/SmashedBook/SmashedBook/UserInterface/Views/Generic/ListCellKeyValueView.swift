//
//  ListCellKeyValueView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 02.03.25.
//

import SwiftUI

struct ListCellKeyValueView<Value>: View {
    @Binding var value: Value
    let exampleValue: String
    let key: String
    let unit: String
    var formatter: Formatter
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(key)
            Spacer()
            HStack {
                TextField(exampleValue, value: $value, formatter: formatter)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(keyboardType)
                Text(unit)
            }
        }
        .frame(minHeight: LayoutConstants.listCellHeight)
        .listRowSeparator(.hidden)
    }
}
