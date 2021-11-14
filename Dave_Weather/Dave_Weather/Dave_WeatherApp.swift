//
//  Dave_WeatherApp.swift
//  Dave_Weather
//
//  Created by Dave Aldrich Cueto on 2021-11-09.
//991476014
//

import SwiftUI

@main
struct Dave_WeatherApp: App {
    var body: some Scene {
        let locationHelper = LocationHelper()
        
        let fetcher = WeatherFetcher()
        
        WindowGroup {
            ContentView().environmentObject(fetcher)
                .environmentObject(locationHelper)
        }
    }
}
