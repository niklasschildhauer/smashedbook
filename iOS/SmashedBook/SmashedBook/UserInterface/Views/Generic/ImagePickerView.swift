//
//  ImagePickerView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 03.09.23.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: View {
    @State var pickedImage: PhotosPickerItem?
    var body: some View {
        if #available(iOS 17.0, *) {
            PhotosPicker(selection: $pickedImage) {
                EmptyView()
            }
            .photosPickerStyle(.inline)
//            .photosPickerAccessoryVisibility(.hidden, edges: .all)
            .ignoresSafeArea()
        }
        else {
            Text("Not availale")
        }
    }
}

#Preview {
    ImagePickerView()
}
