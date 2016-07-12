//
//  Weather.swift
//  Weather-App-Example
//
//  Created by bling on 2016. 7. 10..
//  Copyright © 2016년 test. All rights reserved.
//

import Foundation

struct Weather {
    let cityName: String
    let temp: Double
    let description: String
    let icon: String
    let clouds: Double
    
    var tempC: Double{
        get{
            return temp - 273.15
        }
    }
    
    init(cityName: String,
         temp: Double,
         description:String,
         icon: String,
         clouds: Double){
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.icon = icon
        self.clouds = clouds
    }
}