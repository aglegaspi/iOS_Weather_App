//
//  DetailViewController.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/15/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: PROPERTIES
    var weatherDetails: WeekOfWeather!
    var selectedCity = ""
    var image = ""
    
    //MARK: VIEWS
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.textAlignment = .center
        label.text = "The weather on \(WeekOfWeather.convertDate(convertTime: weatherDetails.time)) for \(selectedCity)"
        return label
    }()
    
    lazy var cityImage: UIImageView = {
        var iv = UIImageView()
        
        ImageHelper.shared.getImage(urlStr: image) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success (let image):
                    iv.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        return iv
    }()
    
    lazy var summaryLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        label.textAlignment = .center
        label.text = weatherDetails.summary
        return label
    }()
    
    /// stack view
    lazy var v1: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        label.text = "High: \(weatherDetails.temperatureHigh ?? 0) ◦F"
        return label
    }()
    
    lazy var v2: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        label.text = "Low: \(weatherDetails.temperatureLow ?? 0) ◦F"
        return label
        
    }()
    
    lazy var v3: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        label.text = "Sunrise: \(weatherDetails.sunriseTime ?? 0)"
        return label
        
    }()
    
    lazy var v4: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        label.text = "Sunset: \(weatherDetails.sunsetTime ?? 0)"
        return label
        
    }()
    
    lazy var v5: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        label.text = "Windspeed: \(weatherDetails.windSpeed ?? 0) MPH"
        return label
        
    }()
    
    lazy var v6: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 10)
        label.text = "Precipitation(Inches): \(weatherDetails.precipProbability ?? 0)"
        return label
        
    }()
    
    lazy var stackView: UIStackView = {
        let s = UIStackView(frame: CGRect(x: 100, y: 510, width: 150, height: 150))
        s.axis = .vertical
        s.distribution = .fillEqually
        s.alignment = .fill
        s.spacing = 0
        s.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        s.addArrangedSubview(self.v1)
        s.addArrangedSubview(self.v2)
        s.addArrangedSubview(self.v3)
        s.addArrangedSubview(self.v4)
        s.addArrangedSubview(self.v5)
        s.addArrangedSubview(self.v6)
        
        return s
    }()
    
    //MARK: LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        loadSubviews()
        loadConstraints()
    }
    
    //MARK: PRIVATE FUNCTIONS
    private func loadSubviews() {
        view.addSubview(dateLabel)
        view.addSubview(cityImage)
        view.addSubview(summaryLabel)
        view.addSubview(stackView)
    }
    
    private func loadConstraints() {
        let constraints = [constrainDateLabel(),constrainCityImage(),constrainSummaryLabel()]
        constraints.forEach { $0 }
    }
    
    
    //MARK: CONSTRAINTS
    private func constrainDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33),
            dateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func constrainCityImage() {
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityImage.topAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            cityImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            cityImage.widthAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    private func constrainSummaryLabel() {
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: cityImage.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            summaryLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            summaryLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    //    private func constrainStackView() {
    //        stackView.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            stackView.topAnchor.constraint(equalTo: summaryLabel.safeAreaLayoutGuide.bottomAnchor, constant: 5),
    //            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
    //            stackView.widthAnchor.constraint(equalToConstant: 200)
    //        ])
    //    }
    
    
    //MARK: OBJC FUNCTIONS
    
    
}
