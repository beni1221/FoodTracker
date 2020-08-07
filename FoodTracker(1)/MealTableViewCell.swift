//
//  MealTableViewCell.swift
//  FoodTracker(1)
//
//  Created by Develosity on 8/6/20.
//  Copyright © 2020 Develosity. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
