//
//  AttachmentModel.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 10.11.23.
//

import Foundation

struct ImageResourceModel: Codable, Hashable, Identifiable {
    var id = UUID()
    let fileName: String
}
