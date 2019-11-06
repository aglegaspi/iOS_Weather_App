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
    
    func save(newFavorite: Favorite) throws {
        try persistenceHelper.save(newElement: newFavorite)
    }
    
    func getFavorites() throws -> [Favorite] {
        return try persistenceHelper.getObjects()
    }
    
    private let persistenceHelper = PersistenceHelper<Favorite>(fileName: "Favorites.plist")
    
    private init() {}
}
