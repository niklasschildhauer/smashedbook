//
//  EditImageListCellView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 26.08.23.
//

import SwiftUI

struct RecipeEditImageListCellView: View {
    let image: Image
    
    var body: some View {
        ListCellWrapperView {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
        }
        .deleteSwipeGesture()
        .frame(height: 100)
    }
}

//https://www.hackingwithswift.com/books/ios-swiftui/using-coordinators-to-manage-swiftui-view-controllers

struct RecipeEditImageListCellView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeEditImageListCellView(image: Image("ExampleRecipe"))
    }
}
