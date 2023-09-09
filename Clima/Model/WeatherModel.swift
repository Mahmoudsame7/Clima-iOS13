//
//  WeatherModel.swift
//  Clima
//
//  Created by Sameh on 29/05/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let name:String
    let temperature:Double
    let weatherConditionId:Int
    
    var temperatureString : String{
        return String(format: "%.1f", temperature)
    }
    
    var weatherConditionName:String{
        switch weatherConditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
