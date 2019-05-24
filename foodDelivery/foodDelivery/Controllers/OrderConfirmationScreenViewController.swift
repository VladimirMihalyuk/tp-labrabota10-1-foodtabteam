//
//  OrderConfirmationScreenViewController.swift
//  foodDelivery
//
//  Created by Aliaxei on 22/05/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
    

class OrderConfirmationScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultCostLabel: UILabel!
    let cellReuseIdentifier = "Cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.register(DishOrderCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        setPrice()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        //AppDataCollections.fillOrder()
     }

    func setPrice(){
        var resultCost: Double = 0
        for i in 0..<AppDataCollections.basketNames.count{
            resultCost += AppDataCollections.basketNames[i].price * Double(AppDataCollections.basketAmounts[i])
        }
        resultCostLabel.text = String(resultCost)
    }
    
    @IBAction func OrderPressed(_ sender: Any) {
        performSegue(withIdentifier: "OrderConfirmationScreenToMap", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDataCollections.basketAmounts.count
    }
    
    @objc func pressed(sender: UIStepper){
        let index = sender.tag
        AppDataCollections.basketAmounts[index] = Int(sender.value)
        if(AppDataCollections.basketAmounts[index] == 0){
            AppDataCollections.basketNames.remove(at: index)
            AppDataCollections.basketAmounts.remove(at: index)
        }
        setPrice()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DishOrderCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! DishOrderCell
        var suppl = ""
        cell.AmountLabel.text = String(AppDataCollections.basketAmounts[indexPath.row])
        if AppDataCollections.basketNames[indexPath.row].supplements != nil{
            suppl = " + " + AppDataCollections.basketNames[indexPath.row].supplements!
        }
        cell.NameLabel.text = AppDataCollections.basketNames[indexPath.row].name! + suppl + "\n" + String(AppDataCollections.basketNames[indexPath.row].price)
        cell.stepper.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
        cell.stepper.value = Double(AppDataCollections.basketAmounts[indexPath.row])
        cell.stepper.tag = indexPath.row
        return cell
    }
    
}

