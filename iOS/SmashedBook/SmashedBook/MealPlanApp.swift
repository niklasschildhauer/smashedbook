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
    private let appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            appCoordinator.rootView
                .ignoresSafeArea()
                .onAppear {
                    appCoordinator.start()
                }
        }
    }
}

