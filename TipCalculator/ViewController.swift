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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Tips"
        
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
       
        tipLabel.text = String(format : "%@ %.2f", getCurSymbol(), 0)
        totalLabel.text = String(format : "%@ %.2f", getCurSymbol(),0)
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true);
    }

    @IBAction func tipPercentageChanged(_ sender: UISegmentedControl) {
        
        let tipPercentages = [0.18, 0.20, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        
        tipLabel.text = String(format : "%@ %.2f", getCurSymbol(), tip)
        totalLabel.text = String(format : "%@ %.2f", getCurSymbol(),total)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        let defaultTipValue = defaults.integer(forKey: "DEFAULT_TIP_PERCENTAGE")
        let bill = Double(billField.text!) ?? 0
        let tip = bill * Double(defaultTipValue) / 100
        let total = bill + tip
      
        
        tipLabel.text = String(format : "%@ %.2f", getCurSymbol(), tip)
        totalLabel.text = String(format : "%@ %.2f", getCurSymbol(),total)
       }
}

