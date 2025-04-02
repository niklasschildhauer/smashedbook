//
//  RecipeDetailGeneralInfoEditView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 21.02.25.
//

import SwiftUI

struct RecipeDetailGeneralInfoEditView: View {
    @Binding var generalInfo: RecipeGeneralInformationModel
    
    var addTitleImage: () -> Void
    
    var body: some View {
        ListSectionView( content: {
            VStack {
                Image.createImageFrom(imageResource: $generalInfo.titleImage.wrappedValue)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
                    .listRowSeparator(.hidden)
                Button("Bearbeiten", action: addTitleImage)
                    .buttonStyle(.bordered)
                TextField("Rezeptname", text: $generalInfo.title)
                    .multilineTextAlignment(.center)
                    .font($generalInfo.font.wrappedValue, fontStyle: .largeTitle)
                    .listRowSeparator(.hidden)
                    .frame(height: 75)
                
                HStack(spacing: LayoutConstants.horizontalSpacing) {
                    ForEach(CustomFont.allCases, id: \.self) { font in
                        Button {
                            generalInfo.font = font
                        } label: {
                            ZStack(alignment: .center) {
                                RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                                    .stroke(.blue, lineWidth: 3)
                                    .frame(width: 40)
                                    .isHidden {
                                        font != generalInfo.font
                                    }
                                Text("Ab")
                                    .font(font, fontStyle: .title)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .selectionDisabled()
        })
        
        ListSectionView(title: "Details", content: {
            ListCellKeyValueView(value: $generalInfo.energy, exampleValue: "450", key: "Kalorien 🔥", unit: "kcal", formatter: NumberFormatter(), keyboardType: .numberPad)
            ListCellKeyValueView(value: $generalInfo.duration, exampleValue: "30", key: "Dauer ⏲️", unit: "min", formatter: NumberFormatter(), keyboardType: .numberPad)
        })
    }
}
