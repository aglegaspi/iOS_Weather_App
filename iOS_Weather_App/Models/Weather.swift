//
//  Weather.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/15/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct WeatherWrapper: Codable {
    let daily: Daily?
}

struct Daily: Codable {
    let data: [Weather]?
}

struct Weather: Codable {
    let time: Int?
    let summary, icon: String?
    let sunriseTime, sunsetTime: Int?
    let precipProbability: Double?
    let precipType: String?
    let temperatureHigh: Double?
    let temperatureLow: Double?
    let windSpeed: Double?
    
    static func getWeather(from data: Data) throws -> [Weather]? {
        do {
            let response = try JSONDecoder().decode(WeatherWrapper.self,from: data)
            print("we are in the get weather model")
            print(response)
            return response.daily?.data
        } catch {
            return nil
        }
    }
}

//    static func convertDate(unixtimeInterval: TimeInterval) -> String {
//        let date = Date(timeIntervalSince1970: unixtimeInterval)
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
//        dateFormatter.locale = NSLocale.current
//        dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
//        let strDate = dateFormatter.string(from: date)
//
//        return strDate
//    }
//
