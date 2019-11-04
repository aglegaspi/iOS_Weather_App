//
//  ImagePersistenceHelper.swift
//  iOS_Weather_App
//
//  Created by Alex 6.1 on 11/1/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct ImagePersistenceHelper {
    static let manager = ImagePersistenceHelper()
    
    func save(newImage: Image) throws {
        try persistenceHelper.save(newElement: newImage)
    }
    
    func getImages() throws -> [Image] {
        return try persistenceHelper.getObjects()
    }
    
    private let persistenceHelper = PersistenceHelper<Image>(fileName: "Images.plist")
    
    private init() {}
}
