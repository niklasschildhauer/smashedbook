//
//  View.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//
//
//import SwiftUI
//
//struct RecipeEditView: View {
//    @Binding var recipe: RecipeModel
//    @Binding var addImageCoordinator: AddImageCoordinator?
//    
//    var body: some View {
//        List {
//            RecipeEditTitleImageSectionView(addImageCoordinator: $addImageCoordinator, titleImage: $recipe.titleImage)
//            RecipeEditNameSectionView(name: $recipe.title)
//            RecipeEditIngredientSectionView(ingredients: $recipe.ingredients)
//            RecipeEditAttachmentSectionView(attachments: $recipe.attachments, addImageCoordinator: $addImageCoordinator)
//        }
//        .listStyle(.insetGrouped)
//    }
//}
//
//#Preview {
//    RecipeEditView(recipe: .constant(recipeModelMock), addImageCoordinator: .constant(nil))
//}
