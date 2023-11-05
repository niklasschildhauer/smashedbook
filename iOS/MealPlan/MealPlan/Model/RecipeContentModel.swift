//
//  RecipeDetailModel.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 17.09.23.
//

import Foundation
import SwiftUI

public struct RecipeContentModel: Codable, Hashable {
    var id = UUID()
    var type: ContentType
    
    public enum ContentType: Codable, Hashable {
        case image(imageUrl: URL)
    }
}

