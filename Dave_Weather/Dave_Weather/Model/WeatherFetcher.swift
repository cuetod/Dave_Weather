//
//  WeatherFetcher.swift
//  Dave_Weather
//
//  Created by Dave Aldrich Cueto on 2021-11-09.
//991476014
//

import SwiftUI
import Foundation
import UIKit
import CoreLocation

class WeatherFetcher : ObservableObject{
    
    //test coordinates for the application
    //    var lat = "43.53268"
//    var long = "-79.691793"
    
    var lat = ""
    var long = ""
    
    var apiURL = ""
    
    @Published var weather = Weather()
    
    init(){
        apiURL = "https://api.weatherapi.com/v1/current.json?key=e232f5f296454cdf8ef170434210911&q=\(lat),\(long)"
        fetchDataFromAPI()
    }
    
    func fetchDataFromAPI(){
        apiURL = "https://api.weatherapi.com/v1/current.json?key=e232f5f296454cdf8ef170434210911&q=\(lat),\(long)"
        guard let api = URL(string: apiURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: api){(data: Data?, response: URLResponse?, error: Error?) in
            
            if let err = error{
                print(#function, err)
            }else{
                //received data or response
                DispatchQueue.global().async {
                    do{
                        if let jsonData = data{
                            let decoder = JSONDecoder()
                            
                            let decodedWeatherObj = try decoder.decode(Weather.self, from: jsonData)
                            
                            DispatchQueue.main.async {
                                self.weather = decodedWeatherObj
                            }
                            
                        }else{
                            print(#function, "No JSON data received")
                        }
                    }catch let error{
                        print(#function, error)
                    }
                }
            }
        }.resume()
    }
    
}
