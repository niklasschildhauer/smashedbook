//
//  EditRecipeAddContentListButtonView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 27.08.23.
//

import SwiftUI
import PhotosUI

struct EditRecipePickPhotoButtonListCellView: View {
    @State private var showImagePicker = false
    @State var pickedImage: PhotosPickerItem?
    
    var body: some View {
        PhotosPicker(selection: $pickedImage, matching: .images, preferredItemEncoding: .compatible) {
            IconLabelListCellView(title: "Foto hinzufügen", image: Image(systemName: "photo"))
        }
//        Button {
//            showImagePicker.toggle()
//        } label: {
//            IconLabelListCellView(title: "Foto hinzufügen", image: Image(systemName: "photo"))
//        }
//        .popover(isPresented: $showImagePicker) {
//            ImagePickerView()
//        }
    }
}

struct EditRecipePickPhotoButtonListCellView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipePickPhotoButtonListCellView()
    }
}
