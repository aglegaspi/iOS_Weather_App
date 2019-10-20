//
//  ViewController.swift
//  iOS_Weather_App
//
//  Created by Alexander George Legaspi on 10/13/19.
//  Copyright © 2019 Alexander George Legaspi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var zipcodeTextfield: UITextField!
    
    //MARK: - LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - IBACTIONS
    @IBAction func enteredZipcode(_ sender: UITextField) {
        
    }
    
    //MARK: - PRIVATE FUNCTIONS
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        ZipCodeHelper.getLatLong(fromZipCode: textField.text ?? "") { (result) in
            switch result {
            case .success(let success):
                print(success)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

