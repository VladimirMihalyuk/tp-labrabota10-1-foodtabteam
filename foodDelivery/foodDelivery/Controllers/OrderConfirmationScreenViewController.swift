//
//  OrderConfirmationScreenViewController.swift
//  foodDelivery
//
//  Created by Aliaxei on 22/05/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class OrderConfirmationScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
     }

    func setPrice()->Int {
        var resultCost: Int = 0
        for cost in AppDataCollections.order.values{
            resultCost += cost
        }
        return resultCost
    }
    
    @IBAction func OrderPressed(_ sender: Any) {
        
    }
    
}

extension OrderConfirmationScreenViewController: UITableViewController{
    
}
