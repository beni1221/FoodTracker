//
//  ViewController.swift
//  FoodTracker(1)
//
//  Created by Develosity on 8/5/20.
//  Copyright © 2020 Develosity. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  var meal: Meal?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // ViewController behet delegat i textfieldit
    nameTextField.delegate = self
    if let meal = meal {
        navigationItem.title = meal.name
        nameTextField.text   = meal.name
        photoImageView.image = meal.photo
        ratingControl.rating = meal.rating
    }
    // save buttoni behet available vetem nese ka tekst te textfieldi
    updateSaveButtonState()
  }
  
  @IBAction func cancelButton(_ sender: Any) {
    let isPresentingInAddMealMode = presentingViewController is UINavigationController
    if isPresentingInAddMealMode {
        dismiss(animated: true, completion: nil)
    }
    else if let owningNavigationController = navigationController{
        owningNavigationController.popViewController(animated: true)
    }
    else {
        fatalError("The MealViewController is not inside a navigation controller.")
    }
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
      // Disable the Save button while editing.
      saveButton.isEnabled = false
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // kur klikon useri, tastatura largohet
    textField.resignFirstResponder()
    // app reagon kur useri klikon return
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    // kontrollon nese useri ka shkruar ne textfield
    updateSaveButtonState()
    // vendos tekstin nga textfieldi ne navigationBar titullin
    navigationItem.title = textField.text
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    // fotoja e zgjedhur nga libraria ruhet ne variabel
    guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      else {
        fatalError("It was waited a folder with images but was delivered the following: \(info)")
    }
    // vendos foton e zgjedhur ne imageView
    photoImageView.image = selectedImage
    // largon pickerImage
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    // largoje formen nese useri e mbyllen
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func selectPhotoFromLibrary(_ sender: UITapGestureRecognizer) {
    // nese useri e klikon foton, keyboardi largohet -> nese useri e ka klikuar textfieldin
    nameTextField.resignFirstResponder()
    // mundeson userin te zgjedh foto nga libaria e telefonit
    let imagePickerController = UIImagePickerController()
    // lokacioni prej ku do merren fotot -> foto librari
    imagePickerController.sourceType = .photoLibrary
    // vendosim imagePicker si delegat te VC -> VC informohet se useri ka zgjedhur 1 foto
    imagePickerController.delegate = self
    // thirren imageVC, shfaq formen e imagePicker, pas ksaj, forma largohet (nil)
    present(imagePickerController, animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      super.prepare(for: segue, sender: sender)
      
      // Configure the destination view controller only when the save button is pressed.
      guard let button = sender as? UIBarButtonItem, button === saveButton else {
          os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
          return
      }
      
      let name = nameTextField.text ?? ""
      let photo = photoImageView.image
      let rating = ratingControl.rating
      
      // Set the meal to be passed to MealTableViewController after the unwind segue.
      meal = Meal(name: name, photo: photo, rating: rating)
  }
  
  func updateSaveButtonState() {
      // Disable the Save button if the text field is empty.
      let text = nameTextField.text ?? ""
      saveButton.isEnabled = !text.isEmpty
  }
}

