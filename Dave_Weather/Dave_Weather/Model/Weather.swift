//
//  Weather.swift
//  Dave_Weather
//
//  Created by Dave Aldrich Cueto on 2021-11-09.
//991476014
//

import Foundation
import SwiftUI

struct Weather: Codable{
    
    var current: Current
    var location: Location
    
    enum CodingKeys: String, CodingKey{
        case current = "current"
        case location = "location"
        
    }
    
    init(){
        current = Current()
        location = Location()
    }
    
}


struct Condition: Codable{
    
    let condition: String
    
    enum CodingKeys: String, CodingKey{
        case condition = "text"
    }
    init(){
        condition = ""
    }
    init(from decoder: Decoder) throws{
        
        let response = try decoder.container(keyedBy: CodingKeys.self)
        
        self.condition = try response.decodeIfPresent(String.self, forKey: .condition) ?? "Una"

    }
}

struct Current : Codable{
    let tempc : Double
    var condition : Condition
    let windkph : Double
    let winddir : String
    let humidity : Double
    let feelslikec : Double
    let viskm : Double
    let uv : Double
    
    enum CodingKeys: String, CodingKey{
        case tempc = "temp_c"
        case feelslikec = "feelslike_c"
        case windkph = "wind_kph"
        case winddir = "wind_dir"
        case humidity = "humidity"
        case uv = "uv"
        case viskm = "vis_km"
        case condition = "condition"
    }
    
    init(){
        tempc = 0.0
        windkph = 0.0
        winddir = ""
        humidity = 0.0
        feelslikec = 0.0
        viskm = 0.0
        uv = 0.0
        condition = Condition()
    }
    
    init (from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.tempc = try response.decodeIfPresent(Double.self, forKey: .tempc) ?? 0.0
        
        self.condition = try response.decodeIfPresent(Condition.self, forKey: .condition) ?? Condition()
        self.windkph = try response.decodeIfPresent(Double.self, forKey: .windkph) ?? 0.0
        self.winddir = try response.decodeIfPresent(String.self, forKey: .winddir) ?? "Unavailable"
        self.humidity = try response.decodeIfPresent(Double.self, forKey: .humidity) ?? 0.0
        self.feelslikec = try response.decodeIfPresent(Double.self, forKey: .feelslikec) ?? 0.0
        self.uv = try response.decodeIfPresent(Double.self, forKey: .uv) ?? 0.0
        self.viskm = try response.decodeIfPresent(Double.self, forKey: .viskm) ?? 0.0
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

struct Location : Codable{
    
    let name : String
    let country : String
    
    init(){
        name = ""
        country = ""
    }
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case country = "country"
        
    }
    
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try response.decodeIfPresent(String.self, forKey: .name) ?? "Unavailable"
        self.country = try response.decodeIfPresent(String.self, forKey: .country) ?? "Unavailable"
    }
    
    
}




