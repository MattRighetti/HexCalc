//
//  ViewController.swift
//  HexCalc
//
//  Created by Mattia Righetti on 02/05/2019.
//  Copyright © 2019 Mattia Righetti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var valueOneTextField: UITextField!
    @IBOutlet var valueTwoTextField: UITextField!
    @IBOutlet var operationLabel: UILabel!
    @IBOutlet var calcButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    let operations = ["+", "-", "*", "%"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonView()
    }

    @IBAction func calcResult(_ sender: Any) {
        if let firstValueAsString = valueOneTextField.text,
            let secondValueAsString = valueTwoTextField.text {
            
            if let firstValue = UInt64(firstValueAsString, radix: 16),
                let secondValue = UInt64(secondValueAsString, radix: 16) {
                
                let result = firstValue - secondValue
                resultLabel.text = "0x" + String(format: "%X", result)
                
            }
            
        } else {
            
            launchAllert()
            
        }
    }
}

extension ViewController {
    
    func setupButtonView() {
        calcButton.layer.cornerRadius = 10
    }
    
    func setupOperationLabel() {
        operationLabel.text = operations[0]
    }
    
    func launchAllert() {
        let alertMissingValues = UIAlertController(title: "Error", message: "Please fill in all the values", preferredStyle: .alert)
        alertMissingValues.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertMissingValues, animated: true, completion: nil)
    }
    
}
