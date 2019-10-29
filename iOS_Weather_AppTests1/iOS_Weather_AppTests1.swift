//
//  iOS_Weather_AppTests1.swift
//  iOS_Weather_AppTests1
//
//  Created by Alexander George Legaspi on 10/19/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import XCTest

class iOS_Weather_AppTests1: XCTestCase {

    func testModelfromJSON() {
        guard let path = Bundle.main.path(forResource: "weather_nyc", ofType: "json") else { print("No Path To JSON Found"); return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let weather = try Weather.getWeather(from: data)
            
            guard let arrWeather = weather else { return }
            
            XCTAssert(arrWeather.count > 0, "We have \(arrWeather.count) days of weather listings")
            
        } catch {
            print(error)
            XCTFail()
        }
    }

}
