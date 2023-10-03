////
////  ContentView.swift
////  MealPlan
////
////  Created by Niklas Schildhauer on 19.08.23.
////
//
//import SwiftUI
//
//enum Route: Hashable {
//    case recipeDetail(RecipeModel)
//}
//
//struct ContentView: View {
//    @State var navigationPath: NavigationPath
//    
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            RecipeOverviewPageView()
//            .navigationDestination(for: Route.self) { route in
//                switch route {
//                case .recipeDetail(let recipe):
//                    RecipeDetailPageView(recipe: .constant(recipe))
//                }
//            }
//        }
//        .uiTestIdentifier("recipeOverviewPageView")
//    }
//}
//
//#Preview {
//    ContentView(navigationPath: NavigationPath())
//}
