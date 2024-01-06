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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .red
//
//        let attrs: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.white,
//            .font: UIFont.monospacedSystemFont(ofSize: 36, weight: .black)
//        ]
//
//        appearance.largeTitleTextAttributes = attrs
//
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        
//        UINavigationBar.appearance()
        

//        navigationBarAppearance.configureWithOpaqueBackground()
//            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
//            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
//            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        
            
        return true
    }
}
