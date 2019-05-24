//
//  DishMenuScreenViewController.swift
//  foodDelivery
//
//  Created by Aliaxei on 22/05/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class DishMenuScreenViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDishes()
        for dish in AppDataCollections.itemDishMenuArray{
            print(dish.name)
        }
        print("loaded")
        collectionView.dataSource = self as! UICollectionViewDataSource
        collectionView.delegate = self as! UICollectionViewDelegate
    }
    
    func loadDishes(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        AppDataCollections.itemDishMenuArray = appDelegate.fetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "DishMenuScreenToDishInformationScreen"{
            if let vc = segue.destination as? DishInformationScreenViewController{
                let dish = sender as? Dish
                vc.dish = dish
            }
        }
    }
    @IBAction func goToBusket(_ sender: Any) {
        self.performSegue(withIdentifier: "DishMenuScreenToOrderConfirmationScreen", sender: nil)
    }
}

extension DishMenuScreenViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath)as? MenuCollectionViewCell{
        itemCell.dish = AppDataCollections.itemDishMenuArray[indexPath.row]
        return itemCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppDataCollections.itemDishMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dish = AppDataCollections.itemDishMenuArray[indexPath.row]
        self.performSegue(withIdentifier: "DishMenuScreenToDishInformationScreen", sender: dish)
    }
    
}
