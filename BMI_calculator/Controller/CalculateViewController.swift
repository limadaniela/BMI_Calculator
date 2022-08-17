//
//  ViewController.swift
//  BMI_calculator
//
//  Created by Daniela Lima on 2022-07-03.
//

import UIKit

class CalculateViewController: UIViewController {
    
    //to use CalculatorBrain in CalculateViewController
    var calculatorBrain = CalculatorBrain()

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    //these IBOutlets are used for IBAction of the calculate button
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    //IBAction for the user to see the values when moving the Slider
    //"%.2f" is used so the value is limited to 2 decimal places after the floating point
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let height = String(format: "%.2f", sender.value)
        heightLabel.text = "\(height)m"
    }
    
    //to display only whole numbers (no decimal places), we need to convert sender.value (which is a Float) into an Integer
    //to convert sender.value into an Integer, you can use -> (Int(sender.value)), OR String(format: "%.0f", sender.value)
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let weight = String(format: "%.0f", sender.value)
        weightLabel.text = "\(weight)kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        
        calculatorBrain.calculateBMI(height: height, weight: weight)
        
        //in Main.storyboard there is a segue between CalculateVC and ResultVC with the identifier "goToResults"
        //segue is responsible for initialising the ResultViewController
        //from the CalculateViewController we can trigger the inherited Method called performSegue
        //to performSegue, we need to put in the Segue identifier. Sender is who is going to be the initiator of the segue way
        //Swift knows that we are using the dismiss Method from this current ResultViewController, so the self keyword is not necessary
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            //when using as, we are using something called Downcasting, and the exclamation mark refers to a forced Downcasting.
            //We have our UIViewController which is the superclass of the ResultViewController.
            //So we can cast it down to our ResultViewController by writing the keyword as.
            //when the segue destination is "goToResult", then the destination view controller that gets created is definitely going to be a ResultViewController.
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
        }
    }
}

