//
//  MealPlanApp.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 19.08.23.
//

import SwiftUI

@main
struct MealPlanApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private let recipeNavigationCoordinator = RecipeNavigationCoordinator()

    var body: some Scene {
        WindowGroup {
            recipeNavigationCoordinator.rootView
                .ignoresSafeArea()
                .onAppear {
                    recipeNavigationCoordinator.start()
                }
        }
    }
}

