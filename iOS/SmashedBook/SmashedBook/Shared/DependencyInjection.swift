//
//  DependencyInjection.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.09.23.
//

import Foundation


// https://www.cobeisfresh.com/blog/dependency-injection-in-swift-using-property-wrappers#:~:text=Dependency%20injection%20is%20a%20design,an%20instance%20of%20such%20service.
//enum DependencyInjectionType {
//    case singleton
//    case newSingleton
//    case new
//    case automatic
//}
//
//class DependencyInjectionContainer {
//    private static var factories: [String: () -> Any] = [:]
//    private static var cache: [String: Any] = [:]
//    
//    static func registerDependency(type: DependencyInjectionType, _ factory: @autoclosure @escaping () -> Service) {
//        factories[String(describing: type.self)] = factory
//    }
//}


/// Wahrscheinlich ist das auch für die Tests praktisch... Dann können die Services alle einfach weggemockt werden!
