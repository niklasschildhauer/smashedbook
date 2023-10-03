//
//  ToolbarViewModifier.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 29.09.23.
//

import SwiftUI

struct BottomToolbarViewModifier<ToolbarContent: View>: ViewModifier {
    //    @Environment(\.dismiss) private var dismiss
        @Environment(\.isPresented) private var isPresented
    @ViewBuilder var toolbarContent: () -> ToolbarContent
    
    func body(content: Content) -> some View {
        content
                    //            .navigationBarHidden(true)
            .safeAreaInset(edge: .bottom, content: {
                HStack(spacing: LayoutConstants.horizontalSpacing) {
                    // TODO: This does not work or is not suitable...
                    //                    if isPresented {
                    //                        HStack {
                    //                            IconFilledButtonView(icon: Image(systemName: "arrow.left")) {
                    //                                dismiss()
                    //                            }
                    //                            .accentColor(.gray)
                    //                            Spacer()
                    //                        }
                    //                    }
                    toolbarContent()
                    
                }
                .padding(.horizontal, LayoutConstants.safeAreaSpacing)
                .frame(height: LayoutConstants.bottomBarHeight)
            })
    }
}

struct TitleBarViewModifier: ViewModifier {
    var title: String
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top, content: {
                HStack(spacing: LayoutConstants.horizontalSpacing) {
                    Text(title)
                        .font(.largeTitle)
                    Spacer()
                }
                .padding(.horizontal, LayoutConstants.safeAreaSpacing)
                .frame(height: LayoutConstants.topBarHeight)
                .background(.white.opacity(0.9))
            })
    }
}

public extension View {
    func bottomToolbar<Content: View>(@ViewBuilder _ content: @escaping () -> Content) -> some View {
        self
            .modifier(BottomToolbarViewModifier(toolbarContent: {
                content()
            }))
    }
    
    //    func titleBar<Content: View>(@ViewBuilder _ content: @escaping () -> Content) -> some View {
    //        self
    //            .modifier(TitleBarViewModifier(titleBarContent: {
    //                content()
    //            }))
    //    }
    
    func titleBar(title: String) -> some View {
        self
            .modifier(TitleBarViewModifier(title: title))
    }
}
