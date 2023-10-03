//
//  Coordinator+Protocol.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.10.23.
//

import SwiftUI

protocol Coordinator {
    associatedtype CoordinatorView: View
    
    var rootView: CoordinatorView { get }
    
    func start()
}
