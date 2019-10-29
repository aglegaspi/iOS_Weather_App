//
//  ViewController.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/13/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weather: [Weather]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var zipcodeTextfield: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        zipcodeTextfield.delegate = self
    }
        
    //MARK: - PRIVATE FUNCTIONS
    
    private func loadWeather(lat: Double, lon: Double) {
        WeatherAPIClient.manager.getWeather(lat: lat, long: lon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherFromOnline):
                    print("we have retrieved weather from online")
                    self.weather = weatherFromOnline
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var output = false
        
        ZipCodeHelper.getLatLong(fromZipCode: textField.text ?? "") { (result) in
            switch result {
            case .success(let success):
                print("we have successfully retrieved long and latitude")
                self.loadWeather(lat: success.lat, lon: success.long)
                output = true
            case .failure(let error):
                print(error)
            }
        }
        return output
    }
    
}

