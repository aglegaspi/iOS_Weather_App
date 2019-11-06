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
    
    var cityname = ""
    var images = [Image]()
    
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
    
    private func loadImage(loadImageForCity: String) {
        
        ImageAPIClient.manager.getImages(cityname: loadImageForCity) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.images = success!
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
                self.cityname = success.name
                self.weatherLabel.text = "Viewing weather for: " + self.cityname
                self.loadImage(loadImageForCity: self.cityname.lowercased().replacingOccurrences(of: " ", with: "+"))
                output = true
            case .failure(let error):
                print(error)
            }
        }
        return output
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let weather = weather?.daily?.data else { return 0 }
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let weather_item = weather?.daily?.data?[indexPath.row] else { return UICollectionViewCell() }
        print(weather_item)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { return UICollectionViewCell() }
        
        print("the cell is now being populated")
        cell.dateLabel.text = WeekOfWeather.convertDate(convertTime: weather_item.time)
        cell.weatherImage.image = UIImage(named: weather_item.icon ?? "none")
        cell.hightempLabel.text = "High: \(String(weather_item.temperatureHigh!))"
        cell.lowtempLabel.text = "Low: \(String(weather_item.temperatureLow!))"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width * 0.4, height: height * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let showdetail = DetailViewController()
        showdetail.weatherDetails = weather?.daily?.data?[indexPath.item]
        showdetail.selectedCity = cityname
        
        showdetail.myImage = images[indexPath.row]
        present(showdetail, animated: true, completion: nil)
        
    }
    
}
