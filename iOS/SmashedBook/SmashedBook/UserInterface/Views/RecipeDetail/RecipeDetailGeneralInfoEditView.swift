//
//  RecipeDetailGeneralInfoEditView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 21.02.25.
//

import SwiftUI

struct RecipeDetailGeneralInfoEditView: View {
    @Binding var title: String
    @Binding var titleImage: ImageResourceModel?
    @Binding var selectedFont: CustomFont
    var addTitleImage: () -> Void
    
    var body: some View {
        VStack {
            Image.createImageFrom(imageResource: $titleImage.wrappedValue)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
                .listRowSeparator(.hidden)
            Button("Bearbeiten", action: addTitleImage)
                .buttonStyle(.bordered)
            TextField("Rezeptname", text: $title)
                .multilineTextAlignment(.center)
                .font($selectedFont.wrappedValue, fontStyle: .largeTitle)
                .listRowSeparator(.hidden)
                .frame(height: 75)
            
            HStack(spacing: LayoutConstants.horizontalSpacing) {
                ForEach(CustomFont.allCases, id: \.self) { font in
                    Button {
                        selectedFont = font
                    } label: {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                                .stroke(.blue, lineWidth: 3)
                                .frame(width: 40)
                                .isHidden {
                                    font != selectedFont
                                }
                            Text("Ab")
                                .font(font, fontStyle: .title)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listRowSeparator(.hidden)
        .selectionDisabled()
    }
}
