//
//  MobileApp.swift
//  Shared
//
//  Created by Guest User on 04/05/2021.
//

import SwiftUI

@main
struct MobileApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: WeatherViewModel())
        }
    }
}
