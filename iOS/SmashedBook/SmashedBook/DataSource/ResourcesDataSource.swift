//
//  AttachmentDataSource.swift
//  MealPlan
//
//  Created by Niklas Schildhauer on 10.11.23.
//

import Foundation
//TODO: Remove it!
import UIKit

protocol ResourcesDataSourceProtocol {
    func load(attachment: ImageResourceModel) -> Data?
    func save(attachmentData: Data) -> ImageResourceModel?
    // TODO: Implement a cache middleware here
}

private let resourcesDataSource = ResourcesDataSource()

class ResourcesDataSource: ResourcesDataSourceProtocol {
    private let fileSystemResourcesDataSource = FileSystemResourcesDataSource()
    
    static func getInstance() -> ResourcesDataSourceProtocol{
        resourcesDataSource
    }
    
    func load(attachment: ImageResourceModel) -> Data? {
        fileSystemResourcesDataSource.load(attachment: attachment)
    }
    
    func save(attachmentData: Data) -> ImageResourceModel? {
        fileSystemResourcesDataSource.save(attachmentData: attachmentData)
    }
}

private class FileSystemResourcesDataSource: ResourcesDataSourceProtocol {
    private var osFileManager: FileManager {
        FileManager.default
    }
    
    func load(attachment: ImageResourceModel) -> Data? {
        guard let fileurl = fileUrl(of: attachment.fileName) else {
            return nil
        }
        
        return try? Data(contentsOf: fileurl)
    }
    
    func save(attachmentData: Data) -> ImageResourceModel? {
        let randomFileName = UUID().uuidString
        guard let fileurl = fileUrl(of: randomFileName) else {
            return nil
        }
            
        do {
            try attachmentData.write(to: fileurl, options: .atomic)
        } catch {
            return nil
        }
        
        return ImageResourceModel(fileName: randomFileName)
    }
    
    private func fileUrl(of fileName: String) -> URL? {
        guard let directory = osFileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return directory.appendingPathComponent("\(fileName)")
    }
}
