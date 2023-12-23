//
//  SectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct SectionView<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: LayoutConstants.verticalSpacing) {
            Text(title.uppercased())
                .fontWeight(.semibold)
                .font(.footnote)
            content()
        }
        .safeAreaPadding(.horizontal, LayoutConstants.safeAreaSpacing)
        .fill(.width)
    }
}

#Preview {
    SectionView(title: "Test headline") {
        Text("Hello world!")
    }
}
