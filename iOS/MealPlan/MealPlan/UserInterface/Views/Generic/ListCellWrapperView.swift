//
//  ListCellWrapperView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 22.08.23.
//

import SwiftUI

struct ListCellWrapperView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .uiTestIdentifierForStackWrapper("listCell")
            .padding(.horizontal, LayoutConstants.horizontalPadding)
    }
}

struct ListCellWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        ListCellWrapperView {
            Text("Test content")
        }
    }
}
