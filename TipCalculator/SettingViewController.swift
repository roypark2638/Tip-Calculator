//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by Roy Park on 11/17/20.
//

import UIKit

class SettingViewController: UIViewController {
    
    
    @IBOutlet weak var tipOneTextField: UITextField!
    @IBOutlet weak var tipTwoTextField: UITextField!
    @IBOutlet weak var tipThreeTextField: UITextField!
    @IBOutlet weak var darkSwitchOnOff: UISwitch!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        defaults.synchronize()
        let newTips = defaults.object(forKey: "savedTips") as? [Double] ?? [Double]()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

       view.addGestureRecognizer(tap)
        tipOneTextField.text = String(newTips[0] * 100)
        tipTwoTextField.text = String(newTips[1] * 100)
        tipThreeTextField.text = String(newTips[2] * 100)
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    @IBAction func tipChanged(_ sender: UITextField) {
        let defaults = UserDefaults.standard
        
        // Set an Double value for some key.

        var newOneTip = Double(tipOneTextField.text!) ?? 0.0
        newOneTip = newOneTip / 100
        var newTwoTip = Double(tipTwoTextField.text!) ?? 0.0
        newTwoTip = newTwoTip / 100.0
        var newThreeTip = Double(tipThreeTextField.text!) ?? 0.0
        newThreeTip = newThreeTip / 100.0
        
        let tipArray = [Double(newOneTip), Double(newTwoTip), Double(newThreeTip)]
        defaults.set(tipArray, forKey: "savedTips")
        defaults.set(newOneTip, forKey: "tipOne")
        defaults.set(newTwoTip, forKey: "tipTwo")
        defaults.set(newThreeTip, forKey: "tipThree")
    }

}
