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
    var demoDict : NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "Orders", ofType: "plist")
        demoDict = NSMutableDictionary(contentsOfFile: path!)
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
        resultString += telephoneField.text!
        resultString += ", "
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


        print(resultString)
        addToPList(value: resultString)
        viewPlist(name: "Orders")
        AppDataCollections.resetData()
        
        performSegue(withIdentifier: "PaymentScreenToDishMenuScreen", sender: self)
    }
    
    func addToPList(value:String?){
        let path = Bundle.main.path(forResource: "Orders", ofType: "plist")
        
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as Array
        
        let docPath = directories[0] as String
        let plistPath = docPath.appending("Orders.plist")
        
        let filemanager = FileManager.default
        
        if(!filemanager.fileExists(atPath: plistPath)) {
            do{
                try filemanager.copyItem(atPath: path!, toPath: plistPath)
            } catch {
                print("copy failure")
            }
        }
        
        demoDict?.setValue(value, forKey: "order")
        
        demoDict?.write(toFile: plistPath, atomically: true)
        
        
    }
    
    func viewPlist(name:String?){
        if let dict = demoDict {
            print("plist: \(dict.value(forKey: "order") ?? "default order")")
        }
    }
    
}
