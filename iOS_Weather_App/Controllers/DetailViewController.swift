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
    
    //MARK: VIEWS
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.text = WeekOfWeather.convertDate(convertTime: weatherDetails.time)
        return label
    }()
    
    lazy var cityImage: UIImage = {
        var image = UIImage()
        return image
    }()
    
    lazy var summaryLabel: UILabel = {
        var label = UILabel()
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
    }
    
    private func loadConstraints() {
        let constraints = [constrainDateLabel()]
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
    
    
    //MARK: OBJC FUNCTIONS
    

}
