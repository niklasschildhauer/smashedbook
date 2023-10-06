//
//  ListSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct ListSectionView<Content: View, TrailingAction: View>: View {
    var title: String?
    var content: () -> Content
    var trailingAction: () -> TrailingAction
    
    init(title: String? = nil,
         @ViewBuilder content: @escaping () -> Content,
         @ViewBuilder trailingAction: @escaping () -> TrailingAction = { EmptyView() }) {
        self.content = content
        self.trailingAction = trailingAction
        self.title = title
    }
    
    var body: some View {
        Section {
            content()
        } header: {
            if let title {
                HStack {
                    Text(title.uppercased())
                        .font(.callout)
                        Spacer()
                        trailingAction()
                }
            }
        }.uiTestIdentifierForStackWrapper("listSection")
    }
    
    // TODO: Remove me!
    var bodyOld: some View {
        VStack(spacing: .zero) {
            if let title {
                HStack {
                    Text(title.uppercased())
                        .font(.footnote)
                        Spacer()
                        trailingAction()
                }
            }
            LazyVStack(spacing: .zero) {
                content()
            }
            .background(Color.green.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }.uiTestIdentifierForStackWrapper("listSection")
    }
    
}

#Preview {
    ListSectionView(title: "Test") {
        Text("Test content")
    }
}

