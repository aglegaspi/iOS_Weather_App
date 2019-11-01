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
        label.backgroundColor = .red
        label.text = weatherDetails.summary
        return label
    }()
    
    lazy var detailsStackView: UIStackView = {
        var stackview = UIStackView()
        return stackview
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
    }
    
    private func loadConstraints() {
        let constraints = [constrainDateLabel(),constrainCityImage(),constrainsummaryLabel()]
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
    
    private func constrainsummaryLabel() {
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: cityImage.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            summaryLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            summaryLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    //MARK: OBJC FUNCTIONS
    

}
