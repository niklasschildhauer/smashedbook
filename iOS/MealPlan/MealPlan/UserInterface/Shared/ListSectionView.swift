//
//  ListSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct ListSectionView<Content: View>: View {
    var title: String?
    var content: () -> Content
    
    init(title: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            if let title = title {
                Text(title.uppercased())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.footnote)
            }
            LazyVStack(spacing: .zero) {
                content()
            }
            .background(Color.green.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
}

struct ListSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ListSectionView(title: "Test") {
            Text("Test content")
        }
    }
}
