//
//  ImageResourceView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 06.01.25.
//

import SwiftUI

struct ImageResourceView: View {
    @Binding var imageResource: ImageResourceModel
    
    private let dataSource = FileSystemAttachmentDataSource()
    
    var body: some View {
        if let imageData = dataSource.load(attachment: imageResource),
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            // todo: proper error handling
            Image("BackButton")
                .resizable()
                .scaledToFill()
        }
    }
}
