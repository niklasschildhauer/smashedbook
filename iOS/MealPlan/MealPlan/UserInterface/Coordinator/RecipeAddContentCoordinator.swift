//
//  RecipeAddContentCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 06.10.23.
//

import SwiftUI

@Observable class RecipeAddContentCoordinator: Coordinator, Identifiable {
    typealias CoordinatorView = RecipeAddContentCoordinatorView
    
    var rootView: RecipeAddContentCoordinatorView {
        RecipeAddContentCoordinatorView(coordinator: self)
    }
    
    var recipeContent: RecipeContentModel? = RecipeContentModel(type: .description(descriptionText: "Test"))
    var didAddRecipeContent: (RecipeContentModel) -> Void
    
    init(didAddRecipeContent: @escaping (RecipeContentModel) -> Void) {
        self.didAddRecipeContent = didAddRecipeContent
    }
    
    func start() { }
}

struct RecipeAddContentCoordinatorView: View {
    @State var coordinator: RecipeAddContentCoordinator
    
    var body: some View {
        IconLabelFilledButtonView(title: "Text hinzufügen", action: {
            // TODO: Clean this up
            if let recipeContent = coordinator.recipeContent {
                coordinator.didAddRecipeContent(recipeContent)
            }
        })
            .onAppear{
                coordinator.start()
            }
    }
}

#Preview {
    RecipeAddContentCoordinatorView(coordinator: .init(didAddRecipeContent: {
        content in
        print(content)
    }))
}
