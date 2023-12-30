//
//  TagView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI

struct TagView: View {
    let text: String
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text("Tagview")
                    .uiTestIdentifierForStackWrapper("tagView")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .colorIt(for: text)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("w\(proxy.frame(in: .global).width)")
                Text("h\(proxy.frame(in: .global).height)")
                Text("min\(proxy.frame(in: .global).minY)")
                Text("max\(proxy.frame(in: .global).maxY)")
            }
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(text: "Test")
    }
}
