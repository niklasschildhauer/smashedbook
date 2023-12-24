//
//  NavigationStack.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 23.12.23.
//

import Foundation

enum NavigationDestination {
    case detail
}

@Observable class NavigationPathStack {
    var stack: [NavigationDestination] = []
    
    func push(destination:NavigationDestination) {
        stack.append(destination)
        print("append new ")
    }
}
