//
//  ViewController.swift
//  foodDelivery
//
//  Created by mac on 5/19/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController {

    @IBOutlet weak var registrationButton: CustomButton!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var termsSwitch: UISwitch!
    @IBOutlet weak var segmController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    segmController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        registrationButton.setTitle("Register", for: .normal)
        
    }
    
    
    @IBAction func registerLoginSwitched(_ sender: Any) {
        if segmController.selectedSegmentIndex == 0{
            repeatPassword.isHidden = false
            termsLabel.isHidden = false
            termsSwitch.isHidden = false
            registrationButton.setTitle("Register", for: .normal)
        }
        else{
            repeatPassword.isHidden = true
            termsLabel.isHidden = true
            termsSwitch.isHidden = true
            registrationButton.setTitle("Login", for: .normal)
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "RegistrationToDishMenuScreen", sender: nil)
    }
    
    
}

