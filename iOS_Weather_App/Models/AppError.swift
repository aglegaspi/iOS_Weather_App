//
//  AppError.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/17/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
