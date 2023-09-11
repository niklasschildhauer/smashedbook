//
//  EditRecipeContentImagePickerView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 07.09.23.
//

import SwiftUI
import PhotosUI

struct EditRecipeContentImagePickerView: View {
    @State var image: PhotosPickerItem?
//    @Binding var pickedImage: Image
    
    var body: some View {
        if #available(iOS 17.0, *) {
            PhotosPicker("", selection: $image)
            
                .photosPickerStyle(.inline)
            
            // Disable the cancel button for an inline use case.
                .photosPickerDisabledCapabilities(.selectionActions)
            
            // Hide padding around all edges in the picker UI.
                .photosPickerAccessoryVisibility(.hidden, edges: .all)
                .ignoresSafeArea()
        } else {
            Text("Not available")
        }
    }
}

#Preview {
    EditRecipeContentImagePickerView()
}
