//
//  BasicOneLineListCellView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 22.08.23.
//

import SwiftUI

struct OneLineTitleCustomElementListCellView<Element:View> : View {
    let customElement: Element
    let title: String
        
    init(title: String, @ViewBuilder content: () -> Element) {
        self.title = title
        self.customElement = content()
    }
    
    var body: some View {
        ListCellWrapperView {
            HStack {
                Text(title)
                Spacer()
                customElement
            }
        }
    }
}

struct OneLineTitleCustomElementListCellView_Previews: PreviewProvider {
    static var previews: some View {
        OneLineTitleCustomElementListCellView(title: "Test Titel") {
            Text("Test")
        }
    }
}
