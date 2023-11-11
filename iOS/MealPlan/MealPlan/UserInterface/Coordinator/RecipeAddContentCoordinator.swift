////
////  RecipeAddContentCoordinator.swift
////  MealPlan
////
////  Created by Niklas Schildhauer on 06.10.23.
////
//
//import SwiftUI
//import Photos
//
//enum RecipeAddContentType: String, CaseIterable {
//    case text
//    case image
//}
//
//@Observable class RecipeAddContentCoordinator: Coordinator, Identifiable {
//    typealias CoordinatorView = RecipeAddContentCoordinatorView
//    
//    var rootView: RecipeAddContentCoordinatorView {
//        RecipeAddContentCoordinatorView(coordinator: self)
//    }
//
//    var didAddRecipeContent: (RecipeContentModel) -> Void
//    var navigationPath = NavigationPath()
//    var selectableContent: [RecipeAddContentType] = [.image]
//    
//    init(didAddRecipeContent: @escaping (RecipeContentModel) -> Void) {
//        self.didAddRecipeContent = didAddRecipeContent
//    }
//    
//    // TODO: do i need the start method?
//    func start() { }
//}
//
//struct RecipeAddContentCoordinatorView: View {
//    @State var coordinator: RecipeAddContentCoordinator
//    @State var addContent: RecipeAttachmentModel?
//    
//    var body: some View {
//        if coordinator.selectableContent.count == 1,
//           let selectedContent = coordinator.selectableContent.first {
//            addContentView(for: selectedContent)
//        } else {
//            NavigationStack(path: $coordinator.navigationPath) {
//                RecipeContentSelectionView { contentType in
//                    coordinator.navigationPath.append(contentType)
//                }
//                .padding(.horizontal, LayoutConstants.safeAreaSpacing)
//                .navigationDestination(for: RecipeAddContentType.self) { contentType in
//                    addContentView(for: contentType)
//                }
//            }
//            .presentationDetents([.medium])
//        }
//    }
//    
//    @ViewBuilder func addContentView(for selectedContent: RecipeAddContentType) -> some View {
//        switch selectedContent {
//        case .text:
//            Text("Needs to be implemented")
//        case .image:
//            ImagePicker { selectedImages in
//                
//            }
//                .bottomToolbar {
//                    IconLabelFilledButtonView(title: "Speichern") {
//                        
//                    }
//                }
//        }
//    }
//}
//
//#Preview {
//    RecipeAddContentCoordinatorView(coordinator: .init(didAddRecipeContent: {
//        content in
//        print(content)
//    }))
//}
