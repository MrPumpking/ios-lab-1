import Foundation

struct WeatherModel {
    var records: Array<WeatherRecord> = []
    
    init(cities: Array<String>) {
        records = Array<WeatherRecord>()
        for city in cities {
            records.append(WeatherRecord(cityName: city))
        }
    }
    
    enum WeatherState: String, CaseIterable {
        case Clear = "Clear"
        case HeavyRain = "Heavy Rain"
        case Snow = "Snow"
    }
    
    struct WeatherRecord: Identifiable {
        var id: UUID = UUID()
        var cityName: String
        var weatherState: WeatherState = WeatherState
            .allCases
            .randomElement() ?? WeatherState.Clear
        var temperature: Float = Float.random(in: -10.0 ... 30.0)
        var humidty: Float = Float.random(in: 0 ... 100)
        var windSpeed: Float = Float.random(in: 0 ... 5)
        var windDirection: Float = Float.random(in: 0 ..< 360)
    }
    
    mutating func refresh(record: WeatherRecord) {
        let idx = records.firstIndex(where: { $0.id == record.id } )
        records[idx!].temperature = Float.random(in: -10.0 ... 30.0)
    }
}
