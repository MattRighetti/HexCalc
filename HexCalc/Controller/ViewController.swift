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
    var opIndex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonView()
        setupOperationLabel()
        setupDismissKeyboardWhenTappedAround()
    }

    @IBAction func calcResult(_ sender: Any) {
        if let firstValueAsString = valueOneTextField.text,
            let secondValueAsString = valueTwoTextField.text {
            
            if !(firstValueAsString.isEmpty || secondValueAsString.isEmpty) {
                
                if let firstValue = UInt64(firstValueAsString, radix: 16),
                    let secondValue = UInt64(secondValueAsString, radix: 16) {
                    
                    let result: UInt64
                    
                    if (opIndex == 0) {
                        result = firstValue + secondValue
                    } else if (opIndex == 1) {
                        result = firstValue - secondValue
                    } else if (opIndex == 2) {
                        result = firstValue * secondValue
                    } else if (opIndex == 3) {
                        result = firstValue / secondValue
                    } else {
                        result = 0
                    }
                    
                    resultLabel.text = "0x" + String(format: "%X", result)
                    
                } else {
                    
                    launchAllert(withTitle: "Out Of Scope Values", "Values are not hexadecimal numbers")
                    
                }
                
            } else {
                
                launchAllert(withTitle: "Value Missing", "Please fill in all the values")
                
            }
        }
    }
}

extension ViewController {
    
    func setupButtonView() {
        calcButton.layer.cornerRadius = 10
    }
    
    func launchAllert(withTitle title: String, _ message: String) {
        let alertMissingValues = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertMissingValues.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertMissingValues, animated: true, completion: nil)
    }
    
    func setupOperationLabel() {
        operationLabel.text = operations[opIndex]
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.updateOperation))
        tapGestureRecognizer.cancelsTouchesInView = false
        operationLabel.addGestureRecognizer(tapGestureRecognizer)
        operationLabel.isUserInteractionEnabled = true
    }
    
    func setupDismissKeyboardWhenTappedAround() {
        let tapAround = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapAround.cancelsTouchesInView = false
        view.addGestureRecognizer(tapAround)
        view.isUserInteractionEnabled = true
    }
    
    @objc func updateOperation() {
        opIndex = (opIndex + 1) % 4
        operationLabel.text = operations[opIndex]
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
