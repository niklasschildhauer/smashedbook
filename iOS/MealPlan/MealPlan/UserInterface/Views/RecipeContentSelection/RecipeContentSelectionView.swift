//
//  RecipeContentSelectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 08.10.23.
//

import SwiftUI

struct RecipeContentSelectionView: View {
    
    var onSelection: (RecipeAddContentType) -> Void
    private let columns = [GridItem(.flexible(minimum: 40), spacing: LayoutConstants.horizontalSpacing), GridItem(.flexible(minimum: 40), spacing: LayoutConstants.horizontalSpacing)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: LayoutConstants.verticalSpacing) {
            ForEach(RecipeAddContentType.allCases, id: \.rawValue) { contentType in
                IconLabelFilledButtonView(title: contentType.rawValue) {
                    onSelection(contentType)
                }
            }
        }
    }
}

#Preview {
    RecipeContentSelectionView() { _ in }
}
