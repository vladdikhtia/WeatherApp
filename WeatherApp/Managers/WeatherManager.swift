//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Vladyslav Dikhtiaruk on 26/12/2023.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    // c592f0407100fe323bd7a6cec2f3d4b4

    
    func getCurrentWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees ) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=c592f0407100fe323bd7a6cec2f3d4b4&units =metric") else { fatalError("Something went wrong with forecast data...")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, res) = try await URLSession.shared.data(for: urlRequest)
        
        guard (res as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data...") }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinateResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinateResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Int
        var humidity: Int
//        var seaLevel: Int
//        var grndLevel: Int
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min}
    var tempMax: Double { return temp_max}
}
