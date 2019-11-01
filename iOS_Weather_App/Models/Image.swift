//
//  Image.swift
//  iOS_Weather_App
//
//  Created by Alex 6.1 on 11/1/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct ImageWrapper: Codable {
    let hits: [Image]?
}

struct Image: Codable {
    let imgURL: String?

    enum CodingKeys: String, CodingKey {
        case imgURL = "webformatURL"
    }
    
    static func getImage(from data: Data) throws -> [Image]? {
        do {
            let response = try JSONDecoder().decode(ImageWrapper.self,from: data)
            return response.hits
        } catch {
            return nil
        }
    }
}
