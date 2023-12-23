//
//  LabelButton.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 20.08.23.
//

import SwiftUI

enum LabelButtonType {
    case cancel
    case primary
    case secondary
}

struct LabelButtonViewModel {
    var action: () -> Void
    var title: String
    var type: LabelButtonType
    
    var color:  Color {
        switch type {
        case .cancel:
            return .red
        case .primary, .secondary:
            return .accentColor
        }
    }
        
    var font: Font {
        switch type {
        case .cancel:
            return .body
        case .primary, .secondary:
            return .system(.body, design: .default, weight: .bold)
        }
    }
    
    static func create(action: @escaping () -> Void , title: String, type: LabelButtonType) -> Self{
        return LabelButtonViewModel(action: action, title: title, type: type)
    }
}

struct LabelButtonView: View {
    let viewModel: LabelButtonViewModel
    
    var body: some View {
        Button(action: viewModel.action) {
            Text(viewModel.title)
                .font(viewModel.font)
                .foregroundColor(viewModel.color)
        }
    }
}

struct LabelButton_Previews: PreviewProvider {
    static var previews: some View {
        LabelButtonView(viewModel: LabelButtonViewModel.create(action: { },
                                                               title: "Action",
                                                               type: .primary))
    }
}
