//
//  ColorBasedOnInputGenerator.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI


// Todo write unit test with the following test cases:
//
struct ColorBasedOnInputGenerator {
    static func generateForegroundColorBasedOnInput(input: String) -> Color {
        return .white
    }
    
    static func generateBackgroundColorBasedOnInput(input: String) -> Color {
        return .blue
    }
    
    private static func generateColorBasedOnInput(input: String) -> Color {
        let hash = input.hashValue
        let red = (hash & 0xFF0000) >> 16
        let green = (hash & 0x00FF00) >> 8
        let blue = (hash & 0x0000FF)
        
        return .clear
    }
}
