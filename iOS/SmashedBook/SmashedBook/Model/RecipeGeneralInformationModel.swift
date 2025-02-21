//
//  RecipeMetaInformationModel.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 02.10.23.
//

import Foundation

public struct RecipeGeneralInformationModel: Codable, Hashable {
    enum Meal: String, Codable, PickerValue {
        case breakfast
        case lunch
        case dinner
        var id: String { self.rawValue }
    }
    
    typealias Calories = Int
    typealias DurationTimeInMinutes = Int
    
    var title: String = ""
    var titleImage: ImageResourceModel?
    var font: CustomFont = .AbrilFatface
    
    var meal: Meal?
    var energy: Calories? 
    var duration: DurationTimeInMinutes?
}
