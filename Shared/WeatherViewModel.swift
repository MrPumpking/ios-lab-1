//
//  WeatherViewModel.swift
//  Mobile
//
//  Created by Guest User on 04/05/2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Alabama", "Kraków", "Warszawa"])
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord) {
        model.refresh(record: record)
    }
    
    
    func getIcon(record: WeatherModel.WeatherRecord) -> String {
        switch record.weatherState {
        case "Snow":
            return "🌨"
        case "Heavy Rain":
            return "🌧"
        default:
            return "☀️"
        }
    }
}
