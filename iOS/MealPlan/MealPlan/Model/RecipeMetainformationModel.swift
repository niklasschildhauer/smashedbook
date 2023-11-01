//
//  RecipeMetaInformationModel.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import Foundation

public struct RecipeMetainformationModel: Codable, Hashable {
    enum Meal: String, Codable, PickerValue {
        case breakfast
        case lunch
        case dinner
        var id: String { self.rawValue }
    }
    
    typealias Calories = Int
    typealias DurationTime = Int
    
    // TODO: Should this be an array?
    var meal: Meal = .lunch
    var energy: Calories?
    var duration: DurationTime?
}
