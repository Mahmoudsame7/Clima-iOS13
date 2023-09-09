//
//  WeatherManager.swift
//  Clima
//
//  Created by Sameh on 28/05/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather:WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=76008e029b8724baec9223d5c8e16483&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName:String){
        let url="\(weatherURL)&q=\(cityName)"
        //print(url)
        performRequest(with: url)
        
    }
    
    func fetchWeather(latitude: CLLocationDegrees ,longitude : CLLocationDegrees){
        let url="\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(url)
        performRequest(with: url)
    }
    func performRequest(with urlString:String){
        
        if let url=URL(string: urlString){
            print("here: " , url)
            let urlSession=URLSession(configuration: .default)
            
            let task=urlSession.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather)
                    }
                }
            }
            
            task.resume()
            
            
        }
        
    }
    func parseJSON(_ weatherData:Data) -> WeatherModel?{
        let decoder=JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name=decodedData.name
            let temp=decodedData.main.temp
            let conditionId=decodedData.weather[0].id
            
            let weather = WeatherModel(name: name, temperature: temp, weatherConditionId: conditionId)
            
           return weather
            
            
        }catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
