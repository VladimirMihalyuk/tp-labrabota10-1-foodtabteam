//
//  OrderConfirmationScreenViewController.swift
//  foodDelivery
//
//  Created by Aliaxei on 22/05/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class OrderConfirmationScreenViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultCostLabel: UILabel!
    let cellReuseIdentifier = "Cell"
    var basketNames: [Dish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        loadBasket()
        resultCostLabel.text = String(setPrice())
        //AppDataCollections.fillOrder()
     }
    
    func loadBasket(){
        for dish in AppDataCollections.order.keys{
            basketNames.append(dish)
        }
    }

    func setPrice()->Double {
        var resultCost: Double = 0
        for (dish, amount) in AppDataCollections.order{
            resultCost += dish.price * Double(amount)
        }
        return resultCost
    }
    
    @IBAction func OrderPressed(_ sender: Any) {
        performSegue(withIdentifier: "OrderConfirmationScreenToMap", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDataCollections.order.count
    }
    
    @objc func pressed(sender: UIStepper){
        let index = sender.tag
        AppDataCollections.order[basketNames[index]] = Int(sender.value)
        if(AppDataCollections.order[basketNames[index]] == 0){
            //basketNames.remove(at: index)
            
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DishOrderCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! DishOrderCell
        cell.AmountLabel.text = String(AppDataCollections.order[basketNames[indexPath.row]]!)
        cell.NameLabel.text = basketNames[indexPath.row].name! + "\n" + String(basketNames[indexPath.row].price)
        cell.stepper.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
        cell.stepper.value = Double(AppDataCollections.order[basketNames[indexPath.row]]!)
        cell.stepper.tag = indexPath.row
        return cell
    }
    
}

