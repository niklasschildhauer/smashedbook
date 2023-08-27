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
        Text(text)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .colorIt(for: text)
            .clipShape(RoundedRectangle(cornerRadius: 8))
  
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(text: "Test")
    }
}
