import Foundation

class WeatherViewModel: ObservableObject {
    @Published private(set) var model: WeatherModel = WeatherModel(
        cities: [
            "Warsaw",
            "Cracow",
            "Berlin",
            "Prague",
            "Moscow",
            "Washington D.C.",
            "New York",
            "Tokyo",
            "Kyoto",
            "Pekin",
            "Dubai"
        ]
    )
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func refresh(record: WeatherModel.WeatherRecord) {
        model.refresh(record: record)
    }
    
    func getIcon(record: WeatherModel.WeatherRecord) -> String {
        switch record.weatherState {
        case WeatherModel.WeatherState.Snow:
            return "🌨"
        case WeatherModel.WeatherState.HeavyRain:
            return "🌧"
        default:
            return "☀️"
        }
    }
}
