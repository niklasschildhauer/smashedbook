//
//  RecipeAddContentCoordinator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 06.10.23.
//

import SwiftUI

enum RecipeAddContentType: String, CaseIterable {
    case text
    case ingredient
    case image
}

@Observable class RecipeAddContentCoordinator: Coordinator, Identifiable {
    typealias CoordinatorView = RecipeAddContentCoordinatorView
    
    var rootView: RecipeAddContentCoordinatorView {
        RecipeAddContentCoordinatorView(coordinator: self)
    }

    var didAddRecipeContent: (RecipeContentModel) -> Void
    var navigationPath = NavigationPath()
    
    init(didAddRecipeContent: @escaping (RecipeContentModel) -> Void) {
        self.didAddRecipeContent = didAddRecipeContent
    }
    
    func start() { }
}

struct RecipeAddContentCoordinatorView: View {
    @State var coordinator: RecipeAddContentCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            RecipeContentSelectionView { contentType in
                coordinator.navigationPath.append(contentType)
            }
            .padding(.horizontal, LayoutConstants.safeAreaSpacing)
            .navigationDestination(for: RecipeAddContentType.self) { contentType in
                switch contentType {
                case .image:
                    Text("Das ist ein Bild")
                case .ingredient:
                    Text("Das ist eine Zutat")
                case .text:
                    Text("Das ist ein Text")
                    Button("Hinzufügen") {
                        coordinator.didAddRecipeContent(RecipeContentModel(type: .description(descriptionText: "Das ist ein Test")))
                    }
                }
            }
        }
        .presentationDetents([.medium])
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
