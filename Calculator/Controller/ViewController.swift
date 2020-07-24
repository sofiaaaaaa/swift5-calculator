//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//  Apple Document :
//  1. UserDefaults - https://developer.apple.com/documentation/foundation/userdefaults
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber: Bool = true
    private var calculator = CalculatorLogic()
    
    let defaults = UserDefaults.standard
    
    // Displayed value on Calculator
    private var displayValue: String {
        
        get {
            return displayLabel.text ?? ""
        }
        
        set {
            displayLabel.text = newValue
            defaults.set(newValue, forKey: "displayValue")
            print("setDisplayNumber() value == \(newValue)")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Load last stored display number
        if let loadValue = defaults.string(forKey: "displayValue") {
            isFinishedTypingNumber = false
            displayValue = loadValue
        }
        
    }
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            let result = calculator.calculate(symbol: calcMethod)
            
            displayValue = result
            
        }
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                displayValue = numValue
                
                isFinishedTypingNumber = false
                
            } else {
                
                if numValue == "." {
                    
                    guard let number = Double(displayValue) else {
                        fatalError("Cannot convert display value.")
                    }
                    
                    if floor(number) == number {
                        displayValue = displayLabel.text! + numValue
                    }
                    
                } else {
                    if displayLabel.text! == "0" {
                        displayValue = numValue
                        
                    } else {
                        
                        displayValue = displayLabel.text! + numValue
                        
                    }
                }
            }
        }
    }
    
}

