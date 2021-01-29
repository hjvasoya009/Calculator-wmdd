//
//  ViewController.swift
//  Calculator
//
//  Created by Hardikkumar Vasoya on 2021-01-26.
//  Copyright © 2021 Hardikkumar Vasoya. All rights reserved.
//

import UIKit

enum modes {
    case not_set
    case addition
    case subtraction
    case multiplication
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var labelString: String = "0"
    var currentMode: modes = .not_set
    var savedNum: Int = 0
    var lastButtonWasMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeModes(newMode: .addition)
    }
    
    
    @IBAction func didPressSubtract(_ sender: Any) {
        changeModes(newMode: .subtraction)
    }
    
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeModes(newMode: .multiplication)
    }
    
    
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelInt: Int = Int(labelString) else {
            return
        }
        
        if (currentMode == .not_set || lastButtonWasMode) {
            return
        }
        
        if (currentMode == .addition) {
            savedNum += labelInt
        }
        else if (currentMode == .subtraction) {
            savedNum -= labelInt
        }
        else if (currentMode == .multiplication) {
            savedNum *= labelInt
        }
        
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    
    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0"
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        label.text = "0"
    }
    
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue: String? = sender.titleLabel?.text
        
        if (lastButtonWasMode) {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue!)
        updateText()
    }
    
    
    func updateText() {
        guard let labelInt: Int = Int(labelString) else {
            return
        }
        
        if (currentMode == .not_set) {
            savedNum = labelInt
        }
        
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num: NSNumber = NSNumber(value: labelInt)
        
        
        label.text = formatter.string(from: num)
    }
    
    func changeModes(newMode: modes) {
        if (savedNum == 0) {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
}

