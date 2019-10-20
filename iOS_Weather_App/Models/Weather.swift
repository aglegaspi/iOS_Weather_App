//
//  Weather.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/15/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation


struct Weather: Codable {
    var timezone: String
    var currently: [Currently]
    var daily: [Daily]
    
    static func getWeather(from data: Data) throws -> Weather? {
        // TODO: 
        do{
            let response = try JSONDecoder().decode(Weather.self,from: data)
            return response
        } catch {
            return nil
        }
    
    }
    
    //    static func convertDate(unixtimeInterval: TimeInterval) -> String {
    //        let date = Date(timeIntervalSince1970: unixtimeInterval)
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    //        dateFormatter.locale = NSLocale.current
    //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
    //        let strDate = dateFormatter.string(from: date)
    //
    //        return strDate
    //    }
    
}

struct Currently: Codable {
    var time: TimeInterval
    var summary: String
    var temperature: Double
}

struct Daily: Codable {
    var icon: String
    var data: [WeatherData]
}

struct WeatherData: Codable {
    var time: TimeInterval
    var summary: String
    var icon: String
    var temperatureHigh: Double
    var temperatureLow: Double
    var sunriseTime: TimeInterval
    var sunsetTime: TimeInterval
    var windspeed: Double
    var precipProbability: Double
    
}



