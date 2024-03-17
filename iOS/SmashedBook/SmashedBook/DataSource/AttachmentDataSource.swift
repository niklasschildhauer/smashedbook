//
//  AttachmentDataSource.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 10.11.23.
//

import Foundation
//TODO: Remove it!
import UIKit

protocol AttachmentDataSource {
    func load(attachment: RecipeAttachmentModel) -> Data?
    func save(attachmentData: Data) -> RecipeAttachmentModel?
    // TODO: Implement a cache middleware here
}

class FileSystemAttachmentDataSource: AttachmentDataSource {
    private var osFileManager: FileManager {
        FileManager.default
    }
    
    func load(attachment: RecipeAttachmentModel) -> Data? {
        guard let fileurl = fileUrl(of: attachment.fileName) else {
            return nil
        }
        
        return try? Data(contentsOf: fileurl)
    }
    
    func save(attachmentData: Data) -> RecipeAttachmentModel? {
        let randomFileName = UUID().uuidString
        guard let fileurl = fileUrl(of: randomFileName) else {
            return nil
        }
            
        do {
            try attachmentData.write(to: fileurl, options: .atomic)
        } catch {
            return nil
        }
        
        return RecipeAttachmentModel(fileName: randomFileName)
    }
    
    private func fileUrl(of fileName: String) -> URL? {
        guard let directory = osFileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return directory.appendingPathComponent("\(fileName)")
    }
}
