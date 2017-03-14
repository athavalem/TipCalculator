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
    
    @IBOutlet weak var currentValue: UILabel!
    @IBOutlet weak var roundDown: UIButton!
    @IBOutlet weak var roundUp: UIButton!
    
    var tip:Double = 0.00
    
    var bill:Double = 0.00
    
    var total:Double = 0.00
    var tipPercentage:Int = 0
    var tipRounding: Double = 0.00
    var locale:NSLocale? = nil
    var currencyFormater: NumberFormatter? = nil
    var currSymbol:String = "$"
    
    
    required init?(coder aDecoder: NSCoder) {
     
        super.init(coder: aDecoder)
        currencyFormater = NumberFormatter()
        locale = NSLocale.current as NSLocale
        currencyFormater?.usesGroupingSeparator = true
        currencyFormater?.numberStyle = NumberFormatter.Style.currency
        
        if #available(iOS 10.0, *) {
            currSymbol =  (locale?.currencyCode!)!
        } else {
            currSymbol = "$"
        }
        

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Tips"
        billField.layer.borderColor = UIColor.black.cgColor
        billField.layer.borderWidth = 1.0
        billField.layer.cornerRadius = 5.0;
        billField.keyboardType = UIKeyboardType.decimalPad
        
        roundDown.backgroundColor = UIColor(red:0.16, green:0.48, blue:1.00, alpha:1.0)
        //roundDown.titleLabel?.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.0)
        
        roundDown.setTitleColor(UIColor.white, for: UIControlState.normal)
        roundDown.layer.cornerRadius = 5
        roundDown.layer.borderWidth = 1
        roundDown.layer.borderColor = UIColor.black.cgColor
        
        //roundUp.backgroundColor = UIColor.blue
        //roundUp.titleLabel?.textColor = UIColor.white
        roundUp.backgroundColor = UIColor(red:0.16, green:0.48, blue:1.00, alpha:1.0)
        //roundDown.titleLabel?.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.0)
        roundUp.setTitleColor(UIColor.white, for: UIControlState.normal)

        roundDown.setTitleColor(UIColor.white, for: UIControlState.normal)
        roundUp.layer.cornerRadius = 5
        roundUp.layer.borderWidth = 1
        roundUp.layer.borderColor = UIColor.black.cgColor
        
       
        
        let defaults = UserDefaults.standard
        tipPercentage = defaults.integer(forKey: "DEFAULT_TIP_PERCENTAGE")
        
        currentValue.text = String (format: "(Current Tip %d %%)",tipPercentage)
        
        tipCalculation()

        
    }
    
    
    func formatTipfields() {
        
        tipLabel.text = String(format : "%@", currencyFormater!.string(from: NSNumber(value:tip))!)
        totalLabel.text = String(format : "%@",currencyFormater!.string(from: NSNumber(value:total))!)

        
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
        billField.becomeFirstResponder()
       
        
        
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
        currentValue.text = String (format: "(Current Tip %d %%)",tipPercentage)

        tipCalculation()
           }
    @IBAction func roundUpPressed(_ sender: UIButton) {
       
        if (bill == 0.00){
        return
        }
        if  tipRounding == 0.5{
            tipRounding = 0.00
        }
        else{
           tipRounding =  +0.5
        }
        tipCalculation()
    }
    
    @IBAction func roundDownPressed(_ sender: Any) {
       
        if (bill == 0.00){
            return
        }
        
        if  tipRounding == -0.5{
            tipRounding = 0.00
        }
        else{
            tipRounding =  -0.5
        }
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
        
        bill = Double(billField.text!) ?? 0
        tipCalculation()
       }
    
    @IBAction func resetAmounts(_ sender: Any) {
        
       tip = 0.00
       total = 0.00
        bill = 0.00
        tipRounding = 0.00
        
        formatTipfields()
        billField.text = ""

        
    }
    func tipCalculation(){
        
        tip = bill * Double(tipPercentage) / 100
        if ( tipRounding != 0.00){
         tip = round(tip + tipRounding)
        }
        total = bill + tip
        print(tipPercentage)
        formatTipfields()

        
    }
}

