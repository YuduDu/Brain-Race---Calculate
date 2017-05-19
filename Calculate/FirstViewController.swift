//
//  FirstViewController.swift
//  Calculate
//
//  Created by Yudu Du on 5/18/17.
//  Copyright © 2017 Yudu Du. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var timer = Timer()
    var time = 180
    let operationArray = ["+","-","x","/"]
    var Score = 0
    var count = 0
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var submit: UIButton!
    @IBOutlet var answerField: UITextField!
    @IBOutlet var questionField: UILabel!
    @IBOutlet var countDownField: UILabel!
    @IBOutlet var scoreField: UILabel!
    @IBOutlet var errorMessage: UIImageView!
    
    var question:String = ""
    var result:Int = -1
    func newQuestion() {
        (question, result, _) = generate(range: 500, In: false)
        questionField.text = question
        answerField.text = ""
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
        errorMessage.isHidden = true
        if let answertext = answerField.text {
            if let answer = Int(answertext){
                if answer == result {
                    Score += 1
                    scoreField.text = String(Score)
                    count = 0
                    newQuestion()
                    return
                }
            }
        }
        answerField.text = ""
        count += 1
        errorMessage.isHidden = false
        if count >= 3 {
            newQuestion()
            count = 0
        }
    }
    func processTimer(){
        if time > 0 {
            time -= 1
            countDownField.text = String(time)
        }
        else {
            timer.invalidate()
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            let record = String(Score) + "-" + formatter.string(from: date)
            if let top = UserDefaults.standard.object(forKey: "topScore") as? Int{
                if top < Score {
                    UserDefaults.standard.set(Score, forKey: "topScore")
                }
            }
            else{
                UserDefaults.standard.set(Score, forKey: "topScore")
            }
            
            if var history = UserDefaults.standard.object(forKey: "history") as? [String] {
                history.insert(record, at: 0)
                UserDefaults.standard.set(history, forKey: "history")
            }
            else{
                UserDefaults.standard.set([record], forKey: "history")
            }
            questionField.text = "Time up!"
            print ("timeout!")
            
        }
    }
    
    func generate(range:UInt32, In:Bool) -> (String, Int, Bool){
        let operation = operationArray[Int(arc4random_uniform(4))]
        if operation == "+" {
            let num1 = Int(arc4random_uniform(range)+1)
            if !In {
                var (formula, result, bracket) = generate(range: range, In:true)
                if bracket {
                    formula = "(" + formula + ")"
                }
                return (String(num1)+"+"+formula, result+num1, false)
            }
            else {
                let num2 = Int(arc4random_uniform(range)+1)
                return (String(num1)+"+"+String(num2), num1+num2, true)
            }
        }
        else if operation == "-" {
            let num1 = Int(arc4random_uniform(range)+1)
            if !In {
                var (formula, result, bracket) = generate(range: range, In: true)
                if bracket {
                    formula = "(" + formula + ")"
                }
                if result >= num1 {
                    return (formula + "-" + String(num1), result - num1, false)
                }
                else{
                    return (String(num1) + "-" + formula, num1 - result, false)
                }
            }
            else{
                let num2 = Int(arc4random_uniform(range)+1)
                return (String(num2+num1) + "-" + String(num1), num2, true)
            }
        }
        else if operation == "x" {
            let num1 = Int(arc4random_uniform(10)+1)
            if !In {
                var (formula, result, bracket) = generate(range: 100, In: true)
                if bracket {
                    formula = "(" + formula + ")"
                }
                return (String(num1) + "x" + formula, result*num1, false)
            }
            else {
                let num2 = Int(arc4random_uniform(100)+1)
                return (String(num1) + "x" + String(num2), num1*num2, false)
            }
        }
        else {
            let num1 = Int(arc4random_uniform(50)+1)
            if !In {
                var (formula, result, _) = generate(range: 50, In: true)
                formula = "(" + formula + ")"
                return (String(num1*result) + "/" + formula, num1, false)
            }
            else {
                let num2 = Int(arc4random_uniform(50)+1)
                return (String(num1*num2) + "/" + String(num1), num2, true)
            }
        
        }
    }
    
    func init_(){
        time = 180
        countDownField.text = String(time)
        startButton.isHidden = false
        Score = 0
        scoreField.text = "000"
        startButton.isHidden = false
        submit.isHidden = true
        questionField.text = "Click Start to begin!"
        answerField.isHidden = true
        errorMessage.isHidden = true
    }
    
    @IBAction func resetGame(_ sender: Any) {
        timer.invalidate()
        init_()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        timer.invalidate()
        init_()
    }
    @IBAction func startGame(_ sender: Any) {
        time = 180
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
        startButton.isHidden = true
        submit.isHidden = false
        answerField.isHidden = false
        newQuestion()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        answerField.keyboardType = UIKeyboardType.numberPad
        init_()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let constraint = NSLayoutConstraint(item: self.answerField, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: keyboardSize.height, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: keyboardSize.height)
            NSLayoutConstraint.activate([constraint])
//            self.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        }
    }
    
//    func keyboardHide(notification: NSNotification) {
//        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
//    }

}

