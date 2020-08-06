//
//  ViewController.swift
//  FoodTracker(1)
//
//  Created by Develosity on 8/5/20.
//  Copyright © 2020 Develosity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var mealNameLabel: UILabel!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // ViewController behet delegat i textfieldit
    nameTextField.delegate = self
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // kur klikon useri, tastatura largohet
    textField.resignFirstResponder()
    // app reagon kur useri klikon return
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    // merr datat nga textFieldi dhe i vendos tek labela
    mealNameLabel.text = textField.text
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
}

