//
//  ImagePersistenceHelper.swift
//  iOS_Weather_App
//
//  Created by Alex 6.1 on 11/1/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct FavoritePersistenceHelper {
    static let manager = FavoritePersistenceHelper()
    
    func save(newFave: Image) throws {
        try persistenceHelper.save(newElement: newFave)
    }
    
    func getBestSellers() throws -> [Image] {
        return try persistenceHelper.getObjects()
    }
    
    func deleteBestSellers(date: Date) throws {
        do {
//            let bestSeller =  try getBestSellers()
//            let newBestSellers = bestSeller.filter { $0.date != date}
//            try persistenceHelper.replace(elements: newBestSellers)
        }
    }
    
    private let persistenceHelper = PersistenceHelper<Image>(fileName: "Images.plist")
    
    private init() {}
}
