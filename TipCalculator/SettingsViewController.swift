//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Madhav Athavale on 3/11/17.
//  Copyright © 2017 Madhav Athavale. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController {

    @IBOutlet weak var selectedTipValue: UISlider!
    @IBOutlet weak var currentTipPercentage: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Back"
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Setup Default Tip"
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let selectedValue = Float(sender.value)
        print(round(selectedValue))
        
        let defaults = UserDefaults.standard
       
        defaults.set(round(selectedValue), forKey: "DEFAULT_TIP_PERCENTAGE")
       
        defaults.synchronize()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
