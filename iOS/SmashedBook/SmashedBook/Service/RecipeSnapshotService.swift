//
//  RecipeSnapshotService.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 15.02.25.
//

import Foundation

class RecipeSnapshotService {
    private var snapshot: RecipeModel? = nil
    
    func saveSnapshot(of recipe: RecipeModel) {
        snapshot = recipe
    }
    
    func getSnapshot() -> RecipeModel? {
        return snapshot
    }
}
