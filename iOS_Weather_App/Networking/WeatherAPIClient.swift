//
//  WeatherAPIHelper.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/17/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct WeatherAPIClient {
    let api_key = Secrets.darksky_api_key
    
    static let manager = WeatherAPIClient()
    
    func getWeather(lat: Double, long: Double, completionHandler: @escaping (Result<[Weather]?, AppError>) -> Void) {
        
        let urlString = "https://api.darksky.net/forecast/\(api_key)/\(lat),\(long)"
        print(urlString)
        
        guard let url = URL(string: urlString) else { fatalError("bad URL") }
        
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
                
            case let .success(data):
                do {
                    let weather = try Weather.getWeather(from: data)
                    completionHandler(.success(weather))
                    print(weather)
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            case let .failure(error):
                completionHandler(.failure(error))
                return
            }
        }
    }
    
    private init() {}
}
