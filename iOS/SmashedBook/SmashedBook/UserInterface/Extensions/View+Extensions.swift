//
//  View+Extensions.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 31.08.23.
//

import SwiftUI

public extension View {
    // Use this function when you want to add a UI Test Identifier to a HStack or VStack View.
    // In https://github.com/yuri-qualtie/MemoryLeaks is described, that the following method leads to memory leaks.
    // I can not reproduce this behaviour, so I will use this method for now.
    func uiTestIdentifierForStackWrapper(_ identifier: String) -> some View {
        self
            .accessibilityElement(children: .contain)
            .accessibilityIdentifier(identifier)
    }
    
    func uiTestIdentifier(_ identifier: String) -> some View {
        self
            .accessibilityIdentifier(identifier)
    }
    
    var identifier: String {
        String(describing: Self.self)
    }
}

