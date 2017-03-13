//
//  ViewController.swift
//  TipCalculator
//
//  Created by Madhav Athavale on 3/10/17.
//  Copyright © 2017 Madhav Athavale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var roundDown: UIButton!
    @IBOutlet weak var roundUp: UIButton!
    
    var tip:Double = 0.00
    
    var bill:Double = 0.00
    
    var total:Double = 0.00
    var tipPercentage:Int = 0
    var tipRounding: Double = 0.00
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Tips"
        billField.layer.borderColor = UIColor.black.cgColor
        billField.layer.borderWidth = 1.0
        billField.layer.cornerRadius = 5.0;
        billField.keyboardType = UIKeyboardType.decimalPad
        
        roundDown.backgroundColor = UIColor.blue
        roundDown.titleLabel?.textColor = UIColor.white
        roundDown.layer.cornerRadius = 5
        roundDown.layer.borderWidth = 1
        roundDown.layer.borderColor = UIColor.black.cgColor
        
        roundUp.backgroundColor = UIColor.blue
        roundUp.titleLabel?.textColor = UIColor.white
        roundUp.layer.cornerRadius = 5
        roundUp.layer.borderWidth = 1
        roundUp.layer.borderColor = UIColor.black.cgColor
      
        let defaults = UserDefaults.standard
        tipPercentage = defaults.integer(forKey: "DEFAULT_TIP_PERCENTAGE")
        
        tipCalculation()

        
    }
    
    
    func formatTipfields() {
        
        tipLabel.text = String(format : "%@ %.2f", getCurSymbol(), tip)
        totalLabel.text = String(format : "%@ %.2f", getCurSymbol(),total)

        
    }
    
    func getCurSymbol () -> String{
    
        let locale = NSLocale.current

        let currencySymbol = locale.currencySymbol
        let currSymbol =  currencySymbol ?? "$"
        return currSymbol
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true);
    }

    @IBAction func tipPercentageChanged(_ sender: UISegmentedControl) {
        
        let segmentedTipPercentages = [0.18, 0.20, 0.25]
        tipPercentage = Int(segmentedTipPercentages[tipControl.selectedSegmentIndex] * 100.00)
        tipCalculation()
           }
    @IBAction func roundUpPressed(_ sender: UIButton) {
        tipRounding =  +0.5
        tipCalculation()
    }
    
    @IBAction func roundDownPressed(_ sender: Any) {
        tipRounding = -0.5
        tipCalculation()

    }
    @IBAction func calculateTip(_ sender: Any) {
//        let defaults = UserDefaults.standard
//        
//        let defaultTipValue = defaults.integer(forKey: "DEFAULT_TIP_PERCENTAGE")
//        bill = Double(billField.text!) ?? 0
//        tip = bill * Double(defaultTipValue) / 100
//        total = bill + tip
//        formatTipfields()
        print ("Hello")
        bill = Double(billField.text!) ?? 0
        tipCalculation()
       }
    
    func tipCalculation(){
        
        tip = bill * Double(tipPercentage) / 100
        tip = round(tip + tipRounding)
        total = bill + tip
        print(tipPercentage)
        formatTipfields()

        
    }
}

