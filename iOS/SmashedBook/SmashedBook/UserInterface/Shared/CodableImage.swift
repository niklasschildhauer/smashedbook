//
//  CodableImage.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 20.06.24.
//

import UIKit

@propertyWrapper
public struct CodableUImage: Codable, Hashable, Identifiable {
    public var id = UUID()
    public var wrappedValue: UIImage
    
    public init(wrappedValue: UIImage) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        guard let image = UIImage(data: data) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid UIImage"
            )
        }
        wrappedValue = image
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.pngData())
    }
}
