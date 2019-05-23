//
//  RestaurantPin.swift
//  foodDelivery
//
//  Created by mac on 5/23/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import MapKit

class RestaurantPin: NSObject, MKAnnotation {
    
    let restaurantName:String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.restaurantName = title
        
        self.coordinate = coordinate
        
        super.init()
    }

    var subtitle: String? {
        return restaurantName
    }
    
}
