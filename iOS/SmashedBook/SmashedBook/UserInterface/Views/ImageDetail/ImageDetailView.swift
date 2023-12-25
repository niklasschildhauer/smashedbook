//
//  ImageDetailView.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 06.12.23.
//

import SwiftUI
import UIKit

struct ImageDetailView: View {
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0
    
    var attachment: RecipeAttachmentModel
    
    // TODO: remove it?
    private let test = FileSystemAttachmentDataSource()
    
    var body: some View {
        if let imageData = test.load(attachment: attachment),
           let uiImage = UIImage(data: imageData) {
            ZoomableScrollView {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
        } else {
            Text("Not loadable")
        }
    }
}


