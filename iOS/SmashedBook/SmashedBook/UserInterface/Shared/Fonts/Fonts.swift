//
//  Fonts.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 10.03.24.
//

import SwiftUI

enum CustomFont {
    case AbrilFatface
    case GeistMedium
    case GeistBlack
    
    enum FontStyle: CGFloat {
        case body = 16
        case footnote = 12
        case largeTitle = 28
        case title = 20
        
        fileprivate func getRelativeTextStyle() -> Font.TextStyle {
            switch self {
            case .body:
                return .body
            case .footnote:
                return.footnote
            case .largeTitle:
                return .largeTitle
            case .title:
                return .title
            }
        }
    }
    
    fileprivate func getFontDefinition() -> CustomFontDefinition {
        return switch self {
        case .AbrilFatface: AbrilFatfaceFontDefinition()
        case .GeistMedium: GeistMediumFontDefinition()
        case .GeistBlack: GeistBlackFontDefinition()
        }
    }
}

struct CustomFontModifier: ViewModifier {
    let customFontDefinition: CustomFontDefinition
    let fontStyle: CustomFont.FontStyle
    
    func body(content: Content) -> some View {
        content
            .font(.custom(customFontDefinition.name, size: customFontDefinition.fontSize(for: fontStyle), relativeTo: fontStyle.getRelativeTextStyle()))
    }
}

extension View {
    func font(_ customFont: CustomFont, fontStyle: CustomFont.FontStyle) -> some View {
        self.modifier(CustomFontModifier(customFontDefinition: customFont.getFontDefinition(), fontStyle: fontStyle))
    }
    
}

protocol CustomFontDefinition {
    var name: String {get }
    func fontSize(for fontstyle: CustomFont.FontStyle) -> CGFloat
}

extension CustomFontDefinition {
    func fontSize(for fontstyle: CustomFont.FontStyle) -> CGFloat {
        fontstyle.rawValue
    }
}

class AbrilFatfaceFontDefinition: CustomFontDefinition {
    let name = "AbrilFatface-Regular"
}

class GeistMediumFontDefinition: CustomFontDefinition {
    let name = "Geist-Medium"
}

class GeistBlackFontDefinition: CustomFontDefinition {
    let name = "Geist-Black"
}
