//
//  MenuCollectionViewCell.swift
//  foodDelivery
//
//  Created by Dick Faggotson on 23.05.2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var dish: Dish?{
        didSet{
            nameLabel.text = dish?.name
            if let image = dish?.image_name{
                imageView.image = UIImage(named: image)
            }
        }
    }
}
