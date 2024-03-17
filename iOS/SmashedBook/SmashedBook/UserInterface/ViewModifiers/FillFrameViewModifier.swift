//
//  FillFrameViewModifier.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 01.11.23.
//

import SwiftUI

struct FillFrameViewModifier: ViewModifier {
    enum FillType{
        case height
        case width
        case frame
    }
    
    let fillType: FillType
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        switch fillType {
        case .height:
            content
                .frame(
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: alignment
                )
        case .width:
            content
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: alignment
                )
        case .frame:
            content
                .frame(
                    minWidth: 0, 
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: alignment
                )
        }
    }
}

extension View {
    func fill(_ frame: FillFrameViewModifier.FillType, alignment: Alignment = .topLeading) -> some View {
        self.modifier(FillFrameViewModifier(fillType: frame, alignment: alignment))
    }
}
