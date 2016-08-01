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
    
    var selection = false
    var answer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainGame()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mainGame() {
        //while true {
            selection = false
            var numbers = getNums()
            num1.text = String(numbers.number1)
            print(numbers.number1)
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
}

