import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        // ScrollView bo chcemy miec mozliwosc przewijania
        ScrollView(.vertical) {
            // VStack zeby ulozyc elementy w kolumnie
            VStack {
                ForEach(viewModel.records) {
                    record in WeatherView(record: record, viewModel: viewModel)
                }
                // Ustawiam padding na scrollowanym elemencie zamiast
                // na scroll view - padding na scroll view powoduje "odstawanie"
                // scrolbara od krawedzi ekranu
            }.padding()
        }
    }
}

enum WeatherViewParam: String, CaseIterable {
    case Temperature = "Temperature: %.2fC"
    case Humidity = "Humidity: %.2f"
    case WindSpeed = "Wind speed: %.2f m/s"
    case WindDirection = "Wind direction: %.2f degrees"
}

struct WeatherView: View {
    @State var currentParamIdx = 0
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    var body: some View {
        // ZStack pozwoli mi ulozyc elementy na sobie
        ZStack {
            RoundedRectangle(cornerRadius: Constants.UI.cardBorderRadius)
                // Potrzebuje tylko ramki
                .stroke()
                // Ustawiam stala wysokosc dla elementu
                .frame(height: Constants.UI.cardHeight)
            // Rozkladam elementy w rzedzie
            HStack {
                // GeometryReader pozwoli mi ustawic rozmiar
                // ikony w zaleznosci od ilosci miejsca jakie
                // zostanie przydzielone na jego kontener
                GeometryReader { geometry in
                    Text(
                        verbatim: viewModel.getIcon(record: record))
                        .font(.system(size: geometry.size.width))
                    // Ustawiam maksymalny rozmiar kontera ikony
                }.frame(maxWidth: Constants.UI.weatherIconMaxWidth)
                // Spacer zapewnia odstep miedzy elementami
                Spacer()
                // VStack zeby ulozyc elementy w kolumnie
                VStack(alignment: .leading) {
                    Text(record.cityName)
                    Text(String(format: WeatherViewParam.allCases[currentParamIdx].rawValue, getCurrentParamValue()))
                        .font(.caption)
                }
                .onTapGesture {
                    iterateWeatherParam()
                }
                // Spacer zapewnia odstep miedzy elementami
                Spacer()
                Text("🔁")
                    // UStawiam font size na predefiniowany
                    .font(.largeTitle)
                    .onTapGesture {
                        viewModel.refresh(record: record)
                    }
            // Dodaje padding
            }.padding()
        }
    }
    
    func getCurrentParamValue() -> Float {
        let currentParam = WeatherViewParam.allCases[currentParamIdx]
        
        switch currentParam {
        case .Temperature:
            return record.temperature
        case .Humidity:
            return record.humidty
        case .WindSpeed:
            return record.windSpeed
        case .WindDirection:
            return record.windDirection
        }
    }
    
    func iterateWeatherParam() -> Void {
        var nextIdx = currentParamIdx + 1
        if (nextIdx >= WeatherViewParam.allCases.count) {
            nextIdx = 0
        }
        currentParamIdx = nextIdx
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
