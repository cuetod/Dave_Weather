//
//  ContentView.swift
//  Dave_Weather
//
//  Created by Dave Aldrich Cueto on 2021-11-09.
//991476014
//

import SwiftUI
import MapKit

struct ContentView: View {

//    @State private var tfLatitude:String = "43.53268"
//    @State private var tfLongitude:String = "-79.691793"

    
    @State private var tfLatitude:String = ""
    @State private var tfLongitude:String = ""
    
//    @State private var lat: String = "43.53268"
//    @State private var lon:String = "-79.691793"
    
    @State private var lat: String = ""
    @State private var lon:String = ""
    
    @State private var result:String = ""
    
    @EnvironmentObject var fetcher : WeatherFetcher
    @EnvironmentObject var locationHelper : LocationHelper
    
    var body: some View {

        NavigationView{

            
            VStack(){
                //Display the properties for the weather
                Text(String(self.fetcher.weather.location.name) + "," + String(self.fetcher.weather.location.country))
                    .foregroundColor(.blue).padding(5).font(Font.system(size: 25))
                Text("The temp is " + String(self.fetcher.weather.current.tempc)+"C and feels like " + String(self.fetcher.weather.current.feelslikec)+"C")
                    .foregroundColor(.red).padding(3).font(Font.system(size: 20))
                Text("Wind direction faces " + String(self.fetcher.weather.current.winddir) + "\n at speed(KPH) " + String(self.fetcher.weather.current.windkph))
                    .foregroundColor(.green).padding(3).font(Font.system(size: 20))
                Text("Condition: " + String(self.fetcher.weather.current.condition.condition))
                    .foregroundColor(.green).padding(3).font(Font.system(size: 20))
                Text("Humidity: " + String(self.fetcher.weather.current.humidity) + " UV: " + String(self.fetcher.weather.current  .uv))
                    .foregroundColor(.green).padding(3).font(Font.system(size: 20))
                
                
                HStack{
                    //Entire properties
                    Form{
                        TextField("Enter latitude",text: $tfLatitude)
                        TextField("Enter longitude",text: $tfLongitude)
                    }//Form
                    //When the form is tapped, the latitude and the longitude changes will apply. This removes the use of buttons
                    .onTapGesture {
                        fetcher.lat = tfLatitude
                        fetcher.long = tfLongitude
                        fetcher.fetchDataFromAPI()
                    }
                }
                
            }// VStack
        }//Navigation
        //When the view is created, the latitude and longitude will be set to the current location of user.
        .navigationTitle("The Weather App").onAppear(){
            self.locationHelper.checkPermission()
            fetcher.lat = String(locationHelper.currentLocation?.coordinate.latitude ?? 0)
            fetcher.long = String(locationHelper.currentLocation?.coordinate.longitude ?? 0)
            fetcher.fetchDataFromAPI()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
