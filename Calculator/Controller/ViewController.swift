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
import AVFoundation // sound

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber: Bool = true
    private var calculator = CalculatorLogic()
    
    let defaults = UserDefaults.standard
    
    // Displayed value on Calculator
    private var displayValue: String {
        
        get {
            var text = displayLabel.text ?? "0"
            text = (Double(text) == nil) ? "0" : text
            return text
        }
        
        set {
            print("setDisplayNumber() value == \(newValue)")
            displayLabel.text = newValue
            defaults.set(newValue, forKey: "displayValue")
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
            // Play sound
//            AudioServicesPlayAlertSound(SystemSoundID(1322))
            
            if isFinishedTypingNumber && numValue != "." {
                
                displayValue = numValue
                
                isFinishedTypingNumber = false
                
            } else {
                
                if numValue == "." {
                    print("displayValue \(displayValue)")
                   let number = Double(displayValue) ?? 0
                    
                    if floor(number) == number {
                        displayValue = displayValue + numValue
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
