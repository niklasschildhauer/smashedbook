//
//  TextEditorWithPlaceholder.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 26.08.24.
//

import SwiftUI

struct TextEditorWithPlaceholder: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                TextEditor(text: .constant(placeholder))
                    .fill(.height, alignment: .leading)
                    .opacity(text.isEmpty ? 0.85 : 1)
            }
            TextEditor(text: $text)
                .fill(.height, alignment: .leading)
                .opacity(text.isEmpty ? 0.85 : 1)
        }
    }
}

#Preview {
    TextEditorWithPlaceholder(text: .constant(""), placeholder: "Write something")
}
