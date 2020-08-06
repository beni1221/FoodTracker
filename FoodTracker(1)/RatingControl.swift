//
//  RatingControl.swift
//  FoodTracker(1)
//
//  Created by Develosity on 8/5/20.
//  Copyright © 2020 Develosity. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
  
  // array me 5 butonat
  private var ratingButtons = [UIButton]()
  // vlera default e ratingsave 0
  var rating = 0 {
    didSet {
      updateButtonSelectionStates()
    }
  }
  
  // da kodojme vet View -> dizajnin
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButtons()
  }
  
  required init(coder: NSCoder){
    super.init(coder: coder)
    setupButtons()
  }
  
  // konstante per width and height e buttonave
  @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
    didSet {
      setupButtons()
    }
  }
  // konstante per numrin e butonave
  @IBInspectable var starCount: Int = 5 {
    didSet {
      setupButtons()
    }
  }
  
  func setupButtons() {
    // fshim butonat e klikuara me heret
    for button in ratingButtons {
      removeArrangedSubview(button)
      button.removeFromSuperview()
    }
    ratingButtons.removeAll()
    
    let bundle = Bundle(for: type(of: self))
    let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
    let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
    let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
    // krijojme 5 buttona me cikel for
    for index in 0..<starCount {
      let button = UIButton()
      // butonave u vendosim foto
      button.setImage(emptyStar, for: .normal)
      button.setImage(filledStar, for: .selected)
      button.setImage(highlightedStar, for: .highlighted)
      button.setImage(highlightedStar, for: [.highlighted, .selected])
      // vendosim constraintsta te buttonit me kod
      button.translatesAutoresizingMaskIntoConstraints = false
      // caktojm height dhe width te buttonit, nepermjet kodit
      button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
      button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
      // vendosim vleren e ratingit ne labelen e butonit
      button.accessibilityLabel = "Set \(index + 1) star rating"
      // kur buttoni klikohet thirret funks. ratingButtonTapped, dhe lejon userin te leviz touchin brenda buttonit -> touchUpInside
      button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
      // vendosim buttonin ne stackview
      addArrangedSubview(button)
      // 5 butonat e krijuara me ciklin for vendosen tek array ratingButtons
      ratingButtons.append(button)
    }
    updateButtonSelectionStates()
  }
  @objc func ratingButtonTapped(button: UIButton) {
    // gjen cili button eshte klikuar, brenda vektorit me index
    guard let index = ratingButtons.firstIndex(of: button) else {
      fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
    }
    // kalkulon ratingin e butonit te zgjedhur
    let selectedRating = index + 1
    
    if selectedRating == rating {
      // nese klikohet butoni i njejt 2her, rating ktehet ne 0
      rating = 0
    } else {
      // Otherwise set the rating to the selected star
      rating = selectedRating
    }
  }
  func updateButtonSelectionStates() {
    for (index, button) in ratingButtons.enumerated() {
        // If the index of a button is less than the rating, that button should be selected.
        button.isSelected = index < rating
      let hintString: String?
      if rating == index + 1 {
          hintString = "Tap to reset the rating to zero."
      } else {
          hintString = nil
      }
       
      // Calculate the value string
      let valueString: String
      switch (rating) {
      case 0:
          valueString = "No rating set."
      case 1:
          valueString = "1 star set."
      default:
          valueString = "\(rating) stars set."
      }
       
      // Assign the hint string and value string
      button.accessibilityHint = hintString
      button.accessibilityValue = valueString
    }
  }
}

