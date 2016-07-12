//
//  ViewController.swift
//  Weather-App-Example
//
//  Created by bling on 2016. 7. 10..
//  Copyright © 2016년 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {

    let weatherService = WeatherService()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
 
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var cityButton: UIButton!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBAction func setCityTapped(sender: UIButton) {
        print("City Button Tapped")
        openCityAlert()
    }
    
    
    
    
    func openCityAlert(){
        let alert = UIAlertController(title:"City", message: "Enter city name", preferredStyle: UIAlertControllerStyle.Alert)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancel)
        
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            (action: UIAlertAction) -> Void in print("OK")
            let textField = alert.textFields?[0]
            //print(textField?.text!)
            //self.cityLabel.text = textField?.text!
            let cityName = textField?.text
            self.weatherService.getWeather(cityName!)
        }
        
        alert.addAction(ok)
        
        alert.addTextFieldWithConfigurationHandler { (textField:UITextField) -> Void in
            textField.placeholder = "City Name"
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func setWeather(weather: Weather) {
        print("*** Set Weather")
        print("City: \(weather.cityName) temp:\(weather.temp) desc:\(weather.description) icon: \(weather.icon)")
        //cityLabel.text = weather.cityName
        tempLabel.text = "\(weather.tempC)"
        descriptionLabel.text = weather.description
        cityButton.setTitle(weather.cityName, forState: .Normal)
        iconImage.image = UIImage(named: "images/\(weather.icon)")
        cloudsLabel.text = "\(weather.clouds)%"
        
    }
    
    func weatherErrorWithMessage(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "ok", style: .Default, handler: nil)
        alert.addAction(ok)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.weatherService.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

