//
//  PaymentScreenViewController.swift
//  foodDelivery
//
//  Created by Aliaxei on 22/05/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class PaymentScreenViewController: UIViewController {

    
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var cardField: UITextField!
    @IBOutlet weak var telephoneField: UITextField!
    @IBOutlet weak var paymentSegment: UISegmentedControl!
    var restaurantName:String?
    var resultString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func paymentChanged(_ sender: Any) {
        if paymentSegment.selectedSegmentIndex == 0{
            cardField.isHidden = false
        }
        else{
            cardField.isHidden = true
        }
    }
    
    func checkFields()->Bool{
        if addressLabel.text == "" || addressLabel.text == "Address"{
            let alertController = UIAlertController(title: "Error!", message: "Enter address!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        else if telephoneField.text == "" || telephoneField.text == "Telephone number"{
            let alertController = UIAlertController(title: "Error!", message: "Enter telephone!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        else if paymentSegment.selectedSegmentIndex == 0 && (cardField.text == "" || cardField.text == "Card number"){
            let alertController = UIAlertController(title: "Error!", message: "Enter card number!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        return true
        
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        if !checkFields(){
            return
        }
        for i in 0..<AppDataCollections.basketAmounts.count{
            resultString += AppDataCollections.basketNames[i].name! + " x" + String(AppDataCollections.basketAmounts[i]) + ", "
        }
        resultString += restaurantName!
        resultString += ", "
        resultString += addressLabel.text!
        resultString += ", "
        if paymentSegment.selectedSegmentIndex == 0{
            resultString += cardField.text!
        }
        else{
            resultString += "cash"
        }
        //add to plist
        //delete data from collections
    }
    
}
