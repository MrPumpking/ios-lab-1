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

struct WeatherView: View {
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
                Text(verbatim: viewModel.getIcon(record: record)).font(.largeTitle)
                // Spacer zapewnia odstep miedzy elementami
                Spacer()
                VStack(alignment: .leading) {
                    Text(record.cityName)
                    Text("Temperature: \(record.temperature, specifier: "%.2f")'C")
                        .font(.caption)
                }
                Spacer()
                Text("🔁")
                    .font(.largeTitle)
                    .onTapGesture {
                        viewModel.refresh(record: record)
                    }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
