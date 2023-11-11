//
//  AttachmentLoaderView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 10.11.23.
//

import SwiftUI

struct AttachmentLoaderView: View  {
    @Binding var attachment: RecipeAttachmentModel
    
    var body: some View {
        Text("Das ist ein Test")
        Button("Hier passiert etwas") {
            
        }
    }
}

#Preview {
    AttachmentLoaderView(attachment: .constant(.init(fileName: UUID().uuidString)))
}
