//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by punky on 2020/07/22.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number: String = ""
    private var isInt: Bool = true
    private var intermediateCalcuation: (n1: Double, calcMethod: String, isInt: Bool)?
    mutating func setNumber(_ value: String) {

        let v = (value == "") ? "0" : value
        
        isInt = v.isInteger
        self.number = v
        
    }
    
    func getIsInt() -> Bool {
        return self.isInt
    }
    
    mutating func calculate(symbol: String) -> String {
        
        if let n = Double(number) {
            if symbol == "+/-" {
                
                if isInt {
                    let intNumber = Int(n) * -1
                    return intNumber.delimiter
                } else {
                    return String(n * -1)
                }
                
            } else if symbol == "AC" {
                
                self.intermediateCalcuation = nil
                return "0"
                
            } else if symbol == "%" {
                
                return String(n * 0.01)
                
            } else if symbol == "=" {
                if let firstNumberInfo = intermediateCalcuation {
                    if let result = performTwoNumCalculation(n2: n) {
                        if isInt && firstNumberInfo.isInt  {
                            let intNumber = Int(result)
                            return intNumber.delimiter
                        } else {
                            return String(result)
                        }
                    }}
                
            } else {
                if let firstNumberInfo = intermediateCalcuation {
                    if let result = performTwoNumCalculation(n2: n) {
                        if isInt && firstNumberInfo.isInt  {
                            intermediateCalcuation = (n1: result, calcMethod: symbol, isInt: isInt)
                            let intNumber = Int(result)
                            
                            return intNumber.delimiter
                        } else {
                            intermediateCalcuation = (n1: result, calcMethod: symbol, isInt: isInt)
                            return String(result)
                        }
                        
                    }
                }
                
                intermediateCalcuation = (n1: n, calcMethod: symbol, isInt: isInt)
                
                return number
                
            }
        }
        
        return ""
    }
    
    
    
    private mutating func performTwoNumCalculation(n2 : Double) -> Double? {
        if let n1 = intermediateCalcuation?.n1,
            let operation = intermediateCalcuation?.calcMethod {
            
            self.intermediateCalcuation = nil
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "*":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        
        return nil
    }
}


// Mark: - StringProtocol Extension

extension StringProtocol {
    var double: Double? { Double(self) }
    var float: Float? { Float(self) }
    var integer: Int? { Int(self) }
    
    var isInteger: Bool { return Int(self) != nil }
    var isFloat: Bool { return Float(self) != nil }
    var isDouble: Bool { return Double(self) != nil }
}



// MARK: - Int Extension
// Source : https://stackoverflow.com/questions/31021197/how-to-add-commas-to-a-number-in-swift
//extension Int {
//    func withCommas() -> String {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        return numberFormatter.string(from: NSNumber(value:self))!
//    }
//}


extension Int {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter
    }()

    var delimiter: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
