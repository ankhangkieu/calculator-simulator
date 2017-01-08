//
//  ViewController.swift
//  calculator-simulator
//
//  Created by Ak Kieu on 1/7/17.
//  Copyright © 2017 Ak Kieu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLbl: UILabel!
    
    var soundEffect: AVAudioPlayer!
    
    enum Operation:String{
        case add = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        case empty = ""
    }
    var num1:String = ""
    var num2:String = ""
    var curNum:String = ""
    var curOp: Operation = Operation.empty

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        do{
            try soundEffect = AVAudioPlayer(contentsOfURL: soundURL)
            soundEffect.prepareToPlay()
        } catch let err as NSError{
            print(err.description)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onNumberPressed(btn: UIButton){
        playSound()
        curNum += "\(btn.tag)"
        resultLbl.text = curNum
    }
    
    @IBAction func onAddPressed(btn: UIButton){
        performOperation(Operation.add)
    }
    
    @IBAction func onSubtractPressed(btn: UIButton){
        performOperation(Operation.subtract)
    }
    
    @IBAction func onMultiplyPressed(btn: UIButton){
        performOperation(Operation.multiply)
    }
    
    @IBAction func onDivdePressed(btn: UIButton){
        performOperation(Operation.divide)
    }
    
    @IBAction func onEqualPressed(btn: UIButton){
        performOperation(curOp)
    }
    
    func performOperation(op: Operation){
        playSound()
        if(curOp != Operation.empty){
            if(curNum != ""){
                num2 = curNum
                if(curOp == Operation.add){
                    resultLbl.text = "\(Double(num1)!+Double(num2)!)"
                }
                else if(curOp == Operation.subtract){
                    resultLbl.text = "\(Double(num1)!-Double(num2)!)"
                }
                else if(curOp == Operation.multiply){
                    resultLbl.text = "\(Double(num1)!*Double(num2)!)"
                }
                else if(curOp == Operation.divide){
                    resultLbl.text = "\(Double(num1)!/Double(num2)!)"
                }
                num1 = resultLbl.text!
                curNum = ""
            }
            curOp = op
        }
        else{
            num1 = curNum
            curNum = ""
            curOp = op
        }
    }
    
    @IBAction func onClearPressed(btn: UIButton){
        resultLbl.text = "0"
        num1 = ""
        num2 = ""
        curNum = ""
        curOp = Operation.empty
    }
    
    func playSound(){
        if soundEffect.playing{
            soundEffect.stop()
        }
        soundEffect.play()
    }
    
}

