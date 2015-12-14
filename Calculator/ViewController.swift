//
//  ViewController.swift
//  Calculator
//
//  Created by David Gudeman on 12/10/15.
//  Copyright © 2015 dmgudeman. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
  
  
  @IBOutlet weak var display: UILabel!
  
  var userIsInTheMiddleOfTypingANumber = false
  
  
  
  @IBAction func appendDigit(sender: UIButton) {
    let digit = sender.currentTitle!
    if userIsInTheMiddleOfTypingANumber {
      display.text = display.text! + digit
    } else {
      display.text = digit
      userIsInTheMiddleOfTypingANumber = true
    }
  }
  
  var operandStack = Array<Double>()
  
  @IBAction func operate(sender: UIButton) {
    let operation = sender.currentTitle!
    if userIsInTheMiddleOfTypingANumber {
      enter()
    }
    switch operation {
    case"×" : performOperation(){ $0 * $1 }
    case"÷" : performOperation(){ $1 / $0 }
    case"+" : performOperation(){ $0 + $1 }
    case"−" : performOperation(){ $1 - $0 }
    case"√" : performOperation(){ sqrt($0) }
    default: break
    }
  }
  
  func performOperation(operation: (Double, Double) -> Double){
    if operandStack.count >= 2 {
      displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
      enter()
    }
  }
  
  
  private func performOperation(operation: Double -> Double){
    if operandStack.count >= 1 {
      displayValue = operation(operandStack.removeLast())
      enter()
    }
  }
  @IBAction func enter() {
    
    userIsInTheMiddleOfTypingANumber = false
    
    //puts the appended displayValue on the stack
    operandStack.append(displayValue)
    print("operandStack = \(operandStack)")
    
    
  }
  
  // processes the display from text to a double or vice versa
  var displayValue: Double {
    get {
      return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
    }
    set {
      display.text = "\(newValue)"
      userIsInTheMiddleOfTypingANumber = false
    }
  }
  
  
  
  
  
  
  
  
  
}

