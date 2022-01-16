//
//  Weather.swift
//  Toy--Project-WeatherApp
//
//  Created by 민선기 on 2022/01/16.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    var current: Current
    var daily: [Daily]
}

struct Current: Codable {
    
}

struct Daily: Codable {
    var dt: Date
    var sunset: Date
    var temp: Temp
    var weather: [Weather]
    
    /// Date를 요일별 Int로 변환하는 함수
    /// - Returns:
    ///     1 = 일요일, 2 = 월요일, 3 = 화요일....
    func weekday() -> Int {
        let calendar = Calendar.current
        let component = calendar.component(.weekday, from: dt)
        return component
    }
}

struct Temp: Codable {
    var min: Double
    var max: Double
    var celsiusTempMin: Int {
        return Int(UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.min))
    }
    var celsiusTempMax: Int {
        return Int(UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.max))
    }
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

// MARK: - Search
struct Search: Codable {
    var weather: [Weather]
    var name: String
    var main: CityTemp
}

struct CityTemp: Codable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    
    var cityCurrentTemp: Int {
        return Int(UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.temp))
    }
    var cityTempMin: Int {
        return Int(UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.tempMin))
    }
    var cityTempMax: Int {
        return Int(UnitTemperature.celsius.converter.value(fromBaseUnitValue: self.tempMax))
    }
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
