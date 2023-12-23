//
//  LoadingResult.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 17.09.23.
//

import Foundation

enum LoadingData<DataModel> {
    case loading
    case success(DataModel)
    case failure(Error)
    case notStarted
}
