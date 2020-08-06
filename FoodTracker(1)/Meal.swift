//
//  Meal.swift
//  FoodTracker(1)
//
//  Created by Develosity on 8/6/20.
//  Copyright © 2020 Develosity. All rights reserved.
//

import UIKit

class Meal {
  var name: String
  var photo: UIImage?
  var rating: Int
  
  init?(name: String, photo: UIImage?, rating: Int) {
    if (name.isEmpty || rating<0) {
      return nil
    }
    self.name = name
    self.photo = photo
    self.rating = rating
  }
}
