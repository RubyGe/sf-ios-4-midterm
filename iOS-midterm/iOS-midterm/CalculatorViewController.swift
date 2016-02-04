//
//  CalculatorViewController.swift
//  iOS-midterm
//
//  Created by Genie Guo on 2/1/16.
//  Copyright © 2016 Genie Guo. All rights reserved.
//

import UIKit

enum CalculationType {
    case Add
    case Subtract
    case Divide
    case Multiply
    case Equal
}

class CalculatorViewController: UIViewController {
    
    
    @IBOutlet var allButtons: [UIButton]!
    
    
    //data storage
    var numberEntered = ""
    var result:Double = 0.0
    var calculationType = CalculationType.Equal
    var number:Double = 0
    
    //display screen label
    @IBOutlet weak var resultLabel: UILabel!
    
    //calculation button
    
    @IBAction func cleanButton(sender: AnyObject) {
        for button in allButtons {
            button.layer.borderWidth = 0
        }
        numberEntered = ""
        result = 0
        number = 0
        resultLabel.text = numberToString(result)
        self.calculationType = CalculationType.Equal
        printNumbers()
    }

    
    @IBAction func oppositeButtonPressed(sender: AnyObject){
        
        number = stringToNumber(self.numberEntered)
        //numberEntered = ""
        number = 0 - number
        resultLabel.text = numberToString(number)
        numberEntered = numberToString(number)
        
    } // @todo
    
    
    @IBAction func percentageButton(sender: UIButton) {
        
        number = stringToNumber(self.numberEntered)
        //numberEntered = ""
        number /= 100
        resultLabel.text = numberToString(number)
        numberEntered = numberToString(number)
        
    }
   
    
    
    @IBAction func generalCalculationButtonPressed(sender: UIButton) {
        //identify calculation type
        for button in allButtons {
            button.layer.borderWidth = 0
        }
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.blackColor().CGColor
        let calculationSymbol = (sender.titleLabel?.text)!
        number = stringToNumber(self.numberEntered)
        numberEntered = ""
        calculateResult(number)
        self.calculationType = identifyCalculationType (calculationSymbol)
        printNumbers()
    }


    func identifyCalculationType (calculationSymbol: String) ->CalculationType {
        
        switch calculationSymbol {
        case "=" :
            return CalculationType.Equal
        case "+" :
            return CalculationType.Add
        case "-" :
            return CalculationType.Subtract
        case "x" :
            return CalculationType.Multiply
        case "÷" :
            return CalculationType.Divide
        default:
            return CalculationType.Equal
        }
    }
    
    //number buttons
    @IBAction func numberPressed(sender: UIButton) {

        let number:String = (sender.titleLabel?.text)!
        numberEntered += number
        resultLabel.text = numberEntered
        printNumbers()
    }
    
    //print variables
    func printNumbers(){
        print("Number Entered: \(self.numberEntered)")
        print("Result: \(self.result)")
        print("Number: \(self.number)")
        print("Calculation Type: \(self.calculationType)")
        
    }
    
   //turn String into Number
    func stringToNumber (string: String) -> Double {
        if string == "" {
            return self.result
        } else {
            if let number = Double(string){
                return number
            } else {
                return 0
            }
        }
        }
    
    //turn number into string
    func numberToString (number: Double) -> String {
        let string:String? = "\(number)"
        return string!
    }
    
    //Calculate Result
    func calculateResult(number: Double) {
        
        switch self.calculationType {
            
        case .Equal:
            self.result = number
        case .Add:
            self.result += number
        case .Subtract:
            self.result -= number
        case .Multiply:
            self.result *= number
        case .Divide:
            if number != 0 {
                self.result /= number
            } else {
                resultLabel.text = "Error"
                result = 0
                return
            }
        }
        resultLabel.text = numberToString(result)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "\(result)"
    }
    
    
    
    

}
