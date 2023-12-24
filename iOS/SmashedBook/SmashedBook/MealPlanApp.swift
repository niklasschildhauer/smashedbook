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

    var body: some Scene {
        WindowGroup {
            AppCoordinator().rootView
        }
    }
}

