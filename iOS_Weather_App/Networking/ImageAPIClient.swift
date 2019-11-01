//
//  ImageAPIClient.swift
//  iOS_Weather_App
//
//  Created by Alex 6.1 on 11/1/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct ImageAPIClient {
    let api_key = Secrets.pixabay_api_key
    
    static let manager = ImageAPIClient()
    
    func getImages(cityname: String, completionHandler: @escaping (Result<[Image]?, AppError>) -> Void) {
        
        let urlString = "https://pixabay.com/api/?key=\(api_key)&q=\(cityname)&image_type=photo"
        
        print(urlString)
        guard let url = URL(string: urlString) else {
            fatalError("bad URL")
        }
        
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                    
                case let .failure(error):
                    completionHandler(.failure(error))
                    return
                    
                case let .success(data):
                    do {
                        let response = try Image.getImage(from: data)
                        completionHandler(.success(response))
                    }
                    catch {
                        completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                    }
                }
            }
        }
    }
    
    private init() {}
}
