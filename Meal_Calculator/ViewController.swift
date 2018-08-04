//
//  ViewController.swift
//  Food Journal
//
//  Created by Paul Yuan on 7/28/18.
//  Copyright © 2018 Paul Yuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    //MARK: tags
    /*
     11: Decimal  (.)
     12: Add      (+)
     13: Subtract (-)
     14: Multiply (x)
     15: Divide   (/)
     16: Reset    (C)
     17: 10% tip
     18: 15% tip
     20: 20% tip
     21: Calculate
     */
    
    enum math{
        case Add
        case Subtract
        case Multiply
        case Divide
        case None
    }
    enum tip{
        case Small  //10%
        case Medium //15%
        case Large  //20%
    }
    
    var curNumber:Double = 0;
    var prevNumber:Double = 0;
    var prevTip:Double = 1;

    var mathMode = math.None
    var isMath = false;
    var tipAmount = tip.Small
   
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var baseCost: UILabel!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipScroll: UIPickerView!
    @IBOutlet weak var myLabel: UILabel!
    
    /*
        Controls the tip bar slider to show/hide it
     */
    @IBAction func tipBarButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        tipLabel.isHidden = !tipLabel.isHidden
        tipSlider.isHidden = !tipSlider.isHidden
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let curValue = Int(sender.value)
        tipLabel.text = String(curValue)
        tipLabel.text = tipLabel.text! + "%"
        tipCalculator(tipPercent: Double(curValue))
    }
    
    
 


    @IBAction func numbers(_ sender: UIButton) {
        if isMath {
            if sender.tag == 11{
                label.text = "."
                curNumber = 0
            }
            else{
                label.text = String(sender.tag-1)
            }
            
            if(label.text != "."){
                curNumber = Double(label.text!)!
            }
            isMath = false;
        }
            
        else{
            if sender.tag == 11 {
                    label.text = label.text! + "."
            }
            else{
                label.text = label.text! + String(sender.tag-1) //tag is always number + 1
            }
            if(label.text != "."){
                curNumber = Double(label.text!)!
            }
        }
        
        baseCost.text = "$" + label.text!
    }
    
    @IBAction func operations(_ sender: UIButton) {
        if label.text != ""{
            switch sender.tag{
                case 12:                    //addition
                    mathMode = math.Add
                    isMath = true
                case 13:                    //subtraction
                    mathMode = math.Subtract
                    isMath = true
                case 14:                    //multiplication
                    mathMode = math.Multiply
                    isMath = true
                case 15:                    //divison
                    mathMode = math.Divide
                    isMath = true
                case 17:
                    tipCalculator(tipPercent: 10)
                case 18:
                    tipCalculator(tipPercent: 15)
                case 21:
                    calculate()
                default:
                    baseCost.text = "$0.00"
                    label.text = ""
                    prevTip = 1
            
            }
            prevNumber = curNumber
        }
        
    }
    
    func tipCalculator(tipPercent: Double){
        let tipMult = 1 + tipPercent/100
        
        tipSlider.value = Float(tipPercent);
        tipLabel.text = String(Int(tipPercent))
        tipLabel.text = tipLabel.text! + "%"
        
        curNumber = curNumber/prevTip
        curNumber = curNumber * tipMult
        curNumber = Double(round(100*curNumber)/100)
        label.text = String(curNumber)
        
        prevTip = tipMult
        
    }
    
    func calculate(){
        print(mathMode)
        print("curNumber: " + String(curNumber))
        print("prevNumber: " + String(prevNumber))
        switch mathMode{
        case .Add:
            curNumber = curNumber + prevNumber
        case .Subtract:
            curNumber = prevNumber - curNumber
        case .Multiply:
            curNumber = prevNumber * curNumber
        case .Divide:
            curNumber = prevNumber / curNumber
        case .None:
            label.text = ""
        }
        
        label.text = String(curNumber)
        baseCost.text = "$" + label.text!
        mathMode = math.None
        isMath = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

