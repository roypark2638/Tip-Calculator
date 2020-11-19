//
//  CalculatorViewController.swift
//  TipCalculator
//
//  Created by Roy Park on 11/17/20.
//

import UIKit
import CoreLocation

class CalculatorViewController: UIViewController{

    
    @IBOutlet weak var userEnterBill: UITextField!
    @IBOutlet weak var partySize: UILabel!
    @IBOutlet weak var tipAmountSegmentedControl: UISegmentedControl!
    @IBOutlet weak var perPersonPriceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPriceLabel: UILabel!
    
    var tipPercentage = 0.15
    var tipPercentages = [0.15, 0.18, 0.2]
    var stepperSize = 1

    
    override func viewWillAppear(_ animated: Bool) {
        userEnterBill.becomeFirstResponder()
        super.viewWillAppear(animated)
        setNewTipAmountToSegmentedControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        super.viewDidLoad()
        
        title = "Calculator"
        calculator()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func userInputPressed(_ sender: Any) {
        calculator()
    }
    @IBAction func tipPercentagePressed(_ sender: Any) {
        tipPercentage = tipPercentages[tipAmountSegmentedControl.selectedSegmentIndex]
        userInputPressed(sender)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        stepperSize = Int(sender.value)
        partySize.text = String(format: "%.0f",sender.value)
        userInputPressed(sender)
    }
    
    
    func setNewTipAmountToSegmentedControl() {
        let defaults = UserDefaults.standard
        defaults.synchronize()
        
        let newTips = defaults.object(forKey: "savedTips") as? [Double] ?? [Double]()
        tipPercentages = newTips
        tipAmountSegmentedControl.setTitle(String(tipPercentages[0] * 100) + "%", forSegmentAt: 0)
        tipAmountSegmentedControl.setTitle(String(tipPercentages[1] * 100) + "%", forSegmentAt: 1)
        tipAmountSegmentedControl.setTitle(String(tipPercentages[2] * 100) + "%", forSegmentAt: 2)
    }
    
    func calculator() {

        
        let bill = Double(userEnterBill.text!) ?? 0
        let tip = bill * tipPercentages[tipAmountSegmentedControl.selectedSegmentIndex]
        let total = bill + tip
        let perPersonPrice = total / Double(stepperSize)
        
        setPriceLabels(perPersonPrice, tip, total)
    }
    
    func setPriceLabels(_ perPersonPrice: Double,_ tip: Double,_ total: Double) {
        
//        let locale = Locale.current
//        let currencySymbol = locale.currencySymbol
//        NumberFormatter.localizedString(from: NSNumber(value: perPersonPrice), number: NumberFormatter.Style.decimal)

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0

        perPersonPriceLabel.text = formatter.string(from: NSNumber(value: perPersonPrice))
        tipPriceLabel.text = formatter.string(from: NSNumber(value: tip))
        totalLabel.text = formatter.string(from: NSNumber(value: total))
        
//        perPersonPriceLabel.text = String(currencySymbol!) + String(format: "%.2f", perPersonPrice)
//        tipPriceLabel.text = String(currencySymbol!) + String(format: "%.2f", tip)
//        totalLabel.text = String(currencySymbol!) + String(format: "%.2f", total)
    }
    
    func getSymbol(forCurrencyCode code: String) -> String? {
        
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }

}

