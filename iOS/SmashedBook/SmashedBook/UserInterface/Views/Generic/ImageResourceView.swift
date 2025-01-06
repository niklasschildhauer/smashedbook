//
//  ImageResourceView.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 06.01.25.
//

import SwiftUI

extension Image {
    static func createImageFrom(imageResource: ImageResourceModel,
                                dataSource: ResourcesDataSourceProtocol = ResourcesDataSource.getInstance()) -> Image {
        if let imageData = dataSource.load(attachment: imageResource),
           let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            // todo: proper error handling
            return Image("BackButton")
        }
    }
}
