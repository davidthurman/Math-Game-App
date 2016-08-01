//
//  ViewController.swift
//  Math Game
//
//  Created by David Thurman on 7/31/16.
//  Copyright © 2016 David Thurman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var num1: UILabel!
    @IBOutlet var num2: UILabel!
    @IBOutlet var operation: UILabel!
    @IBOutlet var answer1: UIButton!
    @IBOutlet var answer2: UIButton!
    @IBOutlet var answer3: UIButton!
    @IBOutlet var answer4: UIButton!
    @IBOutlet var timer: UILabel!
    @IBOutlet var retryButton: UIButton!
    
    var counter: Int?
    var selection = false
    var answer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 0
        timer.text = "0.0"
        retryButton.enabled = false
        retryButton.hidden = true
        mainGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mainGame() {
        //while true {
        counter! += 1
        var myTimer = NSTimer()
        if counter == 1 {
            myTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "incrementTimer", userInfo: nil, repeats: true)

        }
        else if counter == 11 {
            myTimer.invalidate()
            gameEnded()
        }

            selection = false
            var numbers = getNums()
            num1.text = String(numbers.number1)
            num2.text = String(numbers.number2)
            let op = getOperation()
            operation.text = String(op)
            answer = 0
            switch op {
            case "+":
                answer = numbers.number1 + numbers.number2
                break
            case "-":
                answer = numbers.number1 - numbers.number2
                break
            case "%":
                if (Int(numbers.number1) < Int(numbers.number2)){
                    var temp = numbers.number1
                    numbers.number1 = numbers.number2
                    numbers.number2 = temp
                    num1.text = String(numbers.number1)
                    num2.text = String(numbers.number2)
                }
                answer = numbers.number1 % numbers.number2
                break
            case "*":
                answer = numbers.number1 * numbers.number2
            default: break
            }
            setButtons()
//            while !selection{
//                
//            }
            
       // }
    }

    func getOperation() -> String {
        let x = arc4random_uniform(4)
        switch x {
        case 0:
            return "+"
        case 1:
            return "-"
        case 2:
            return "%"
        case 3:
            return "*"
        default:
            return "+"
        }
        
    }
    
    func getNums() -> (number1: Int, number2: Int){
        let number1 = Int(arc4random_uniform(10) + 1)
        let number2 = Int(arc4random_uniform(10) + 1)
        return (number1, number2)
    }
    
    func setButtons() {
        let correctButton = Int(arc4random_uniform(4))
        var choices = [Int]()
        for var x in -10...10 {
            if x != 0{
                choices.append(answer + x)
            }
        }

        choices = setNumberForButton(choices, button: answer1)
        choices = setNumberForButton(choices, button: answer2)
        choices = setNumberForButton(choices, button: answer3)
        choices = setNumberForButton(choices, button: answer4)

        
        switch correctButton {
        case 0:
            answer1.setTitle(String(answer), forState: .Normal)
        case 1:
            answer2.setTitle(String(answer), forState: .Normal)
        case 2:
            answer3.setTitle(String(answer), forState: .Normal)
        case 3:
            answer4.setTitle(String(answer), forState: .Normal)
        default:
             break
        }
        
    }
    
    func setNumberForButton(choices: [Int], button: UIButton) -> [Int] {
        var choices = choices
        var rand = Int(arc4random_uniform(19))
        while choices[rand] == 10000 {
            rand = Int(arc4random_uniform(19))
        }
        button.setTitle(String(choices[rand]), forState: .Normal)
        choices[rand] = 10000
        
        return choices
    }
    
    func checkAnswer(choice: Int) -> Bool{
        if choice == answer{
            selection = true
            return true
        }
        else{
            selection =  false
            return false
        }
    }
    @IBAction func answer1Selection(sender: AnyObject) {
        if checkAnswer(Int((answer1.titleLabel?.text)!)!) {
            mainGame()
        }
    }
    @IBAction func answer2Selection(sender: AnyObject) {
        if checkAnswer(Int((answer2.titleLabel?.text)!)!) {
            mainGame()
        }
    }
    @IBAction func answer3Selection(sender: AnyObject) {
        if checkAnswer(Int((answer3.titleLabel?.text)!)!){
            mainGame()
        }
    }
    @IBAction func answer4Selection(sender: AnyObject) {
        if checkAnswer(Int((answer4.titleLabel?.text)!)!){
            mainGame()
        }
    }
    
    func incrementTimer(){
        let x = Double(timer.text!)
        timer.text = String(x! + 0.1)
    }
    
    func gameEnded(){
        timer.hidden = true
        answer1.hidden = true
        answer2.hidden = true
        answer3.hidden = true
        answer4.hidden = true
        num1.hidden = true
        num2.hidden = true
        operation.hidden = true
        retryButton.hidden = false
        retryButton.enabled = true
        retryButton.setTitle("Time: \(timer.text!)\n   Retry?", forState: .Normal)
    }
    
    @IBAction func retryAction(sender: AnyObject) {
        timer.hidden = false
        timer.text = "0.0"
        retryButton.enabled = false
        retryButton.hidden = true
        answer1.hidden = false
        answer2.hidden = false
        answer3.hidden = false
        answer4.hidden = false
        num1.hidden = false
        num2.hidden = false
        operation.hidden = false
        counter = 0
    }
}

