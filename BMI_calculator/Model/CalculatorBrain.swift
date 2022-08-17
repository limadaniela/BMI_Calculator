//
//  CalculatorBrain.swift
//  BMI_calculator
//
//  Created by Daniela Lima on 2022-07-04.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    func getBMIValue() -> String {
        //?? Nil coalescing operator
        //bmi?.value optional chaining
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiTo1DecimalPlace
    }
    
    func getAdvice() -> String {
        //bmi?.advice optional chaining to access bmi properties
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
    
    //bmi is a property of our struct, and structs are imutable. So in order to change it, we need to mark this Method as 'mutating' to make 'self' mutable
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / pow(height, 2)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: UIColor.systemBlue)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: UIColor.systemGreen)
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: UIColor.systemRed)
        }
    }
}
