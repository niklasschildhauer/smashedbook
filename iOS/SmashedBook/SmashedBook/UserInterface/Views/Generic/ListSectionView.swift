//
//  ListSectionView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct ListSectionView<Content: View, TrailingAction: View, BottomAction: View>: View {
    var title: String?
    var content: () -> Content
    var trailingAction: () -> TrailingAction
    var bottomAction: () -> BottomAction
    
    init(title: String? = nil,
         @ViewBuilder content: @escaping () -> Content,
         @ViewBuilder trailingAction: @escaping () -> TrailingAction = { EmptyView() },
         @ViewBuilder bottomAction: @escaping () -> BottomAction = { EmptyView() }) {
        self.content = content
        self.trailingAction = trailingAction
        self.bottomAction = bottomAction
        self.title = title
    }
    
    var body: some View {
        Section {
            content()
            bottomAction()
        } header: {
            if let title {
                HStack {
                    Text(title.uppercased())
                        .fontWeight(.semibold)
                        .font(.GeistMedium, fontStyle: .footnote)
                        .foregroundStyle(.gray)
                        Spacer()
                        trailingAction()
                }
            }
        }
        .listRowInsets(.init(top: LayoutConstants.verticalSpacing/2, leading: LayoutConstants.safeAreaSpacing, bottom: LayoutConstants.verticalSpacing/2, trailing: LayoutConstants.safeAreaSpacing))
        .listSectionSeparator(.hidden)
        .uiTestIdentifierForStackWrapper("listSection")
    }
}

#Preview {
    ListSectionView(title: "Test") {
        Text("Test content")
    }
}

