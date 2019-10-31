//
//  ViewController.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/13/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weather: Weather? {
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
        
    //MARK: - PRIVATE FUNCTIONS
    
    private func loadWeather(lat: Double, lon: Double) {
        WeatherAPIClient.manager.getWeather(lat: lat, long: lon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherFromOnline):
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
                self.loadWeather(lat: success.lat, lon: success.long)
                self.weatherLabel.text = success.name
                output = true
            case .failure(let error):
                print(error)
            }
        }
        return output
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let weather = weather?.daily?.data else { return 0 }
        print(weather.count)
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let weather_item = weather?.daily?.data?[indexPath.row] else { return UICollectionViewCell() }
        print(weather_item)
        print("the cell how has an array of data")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { return UICollectionViewCell() }
        
        print("the cell is now being populated")
        cell.dateLabel.text = WeekOfWeather.convertDate(convertTime: weather_item.time)
        
        return cell
    }
    
    
}
