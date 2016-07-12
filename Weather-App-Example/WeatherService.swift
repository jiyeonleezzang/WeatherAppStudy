//
//  WheaterService.swift
//  Weather-App-Example
//
//  Created by bling on 2016. 7. 10..
//  Copyright © 2016년 test. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate{
    func setWeather(weatger: Weather)
    func weatherErrorWithMessage(message: String)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    func getWeather(city:String){
        //jiyeonleezzang@gmail.com key: ebf0a5322bd037b754f34cde3517c9b3
        
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let appid = "ebf0a5322bd037b754f34cde3517c9b3"
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=\(appid)"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data:NSData?, resoonse: NSURLResponse?, error:NSError?) -> Void in
            //print(">>> \(data)")
            
            if let httpResponse = resoonse as? NSHTTPURLResponse{
                print(httpResponse.statusCode)
            }
            
            let json = JSON(data: data!)
            
            var status = 0;
            if let cod = json["cod"].int {
                status = cod
            }else if let cod = json["cod"].string {
                status = Int(cod)!
            }
            
            if status == 200{
            
                let lon = json["coord"]["lon"].double
                let lat = json["coord"]["lat"].double
                let temp = json["main"]["temp"].double
                let name = json["name"].string
                let desc = json["weather"][0]["description"].string
                let icon = json["weather"][0]["icon"].string
                let clouds = json["clouds"]["all"].double
            
                let weather = Weather(cityName: name!, temp: temp!, description: desc!, icon: icon!, clouds:clouds!)
            
                if self.delegate != nil {
                
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.setWeather(weather)
                    })
                
                }
            }else if status == 404 {
                // City not found
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.weatherErrorWithMessage("City not found")
                    })
                }
                
            } else {
                // Some other here?
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.weatherErrorWithMessage("Something went wrong?")
                    })
                }
                
            }            //print("Lat: \(lat!) lon: \(lon!) temp: \(temp!)")
        }
        task.resume()
        
        //print("Weather Service city: \(city)")
        /*
        let weather = Weather(cityName: city, temp: 237.12, description: "A nice day")
        
        if delegate != nil {
             delegate?.setWeather(weather)
        }
        */
       
    }
}