//
//  DishInformationScreenViewController.swift
//  foodDelivery
//
//  Created by Aliaxei on 22/05/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class DishInformationScreenViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!{
        didSet{
            name.text = dish?.name
        }
    }
    
    @IBOutlet weak var cost: UILabel!{
        didSet{
            cost.text = "\(dish!.price) $"
        }
    }
    
    @IBOutlet weak var image: UIImageView!{
        didSet{
            guard let imageName = dish?.image_name else{return}
            image.image = UIImage(named: imageName)
        }
    }
    
    @IBOutlet weak var descriptionOfDish: UILabel!{
        didSet{
            descriptionOfDish.text = dish?.composition
        }
    }
    
    @IBOutlet weak var additional: UILabel!{
        didSet{
            additional.text = dish?.supplements
        }
    }
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var count: UILabel!
    
    @IBOutlet weak var plusMinus: UIStepper!
    

    @IBAction func addToBusket(_ sender: Any) {
        
        if segment.selectedSegmentIndex == 0{
            dish?.supplements = nil
        } else {
            dish?.supplements = dishSupplement
        }
        
        for i in 0..<AppDataCollections.basketNames.count{
            if AppDataCollections.basketNames[i].name == dish?.name{
                if AppDataCollections.basketNames[i].supplements == dish?.supplements{
                    AppDataCollections.basketAmounts[i] += Int(plusMinus.value)
                    return
                }
                
            }
        }
        AppDataCollections.basketNames.append(dish!)
        AppDataCollections.basketAmounts.append(Int(plusMinus.value))
        let alertController = UIAlertController(title: "Success!", message: "Dish has been added to busket!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        self.updateViewConstraints()
    }
    
    @IBAction func goToBusket(_ sender: Any) {
        self.performSegue(withIdentifier: "DishInformationScreenToOrderConfirmationScreen", sender: nil)
    }
    
    var dish: Dish?
    var dishSupplement:String?
    
    @IBAction func changeValue(_ sender: Any) {
        count.text = "\(plusMinus.value)"
        self.updateViewConstraints()    
        //count.reloadInputViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        plusMinus.value = 1
        count.text = "\(plusMinus.value)"
        dishSupplement = dish?.supplements
        
    }
    

  

}
