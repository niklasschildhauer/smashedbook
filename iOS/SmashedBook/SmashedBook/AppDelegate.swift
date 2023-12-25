//
//  AppDelegate.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 21.12.23.
//

import Foundation
import MSAL
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return MSALPublicClientApplication.handleMSALResponse(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
    }
}
