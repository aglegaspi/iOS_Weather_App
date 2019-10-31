//
//  Weather.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/15/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let timezone: String?
    let daily: Daily?
    
    static func getWeather(from data: Data) throws -> Weather? {
        do {
            let response = try JSONDecoder().decode(Weather.self,from: data)
            return response
        } catch {
            return nil
        }
    }
}

struct Daily: Codable {
    let summary, icon: String?
    let data: [WeekOfWeather]?
}

struct WeekOfWeather: Codable {
    let time: Int?
    let summary, icon: String?
    let sunriseTime, sunsetTime: Int?
    let precipProbability: Double?
    let precipType: String?
    let temperatureHigh: Double?
    let temperatureLow: Double?
    let windSpeed: Double?
    

    static func convertDate(convertTime: Int?) -> String {
        guard let convertThis = convertTime else { return "Could Not Convert" }
        let converted = TimeInterval(convertThis)
        let date = Date(timeIntervalSince1970: converted)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)

        return strDate
    }
}
