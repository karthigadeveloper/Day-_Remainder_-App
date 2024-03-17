//
//  AddViewController.swift
//  simple_remainder_app
//
//  Created by Karthiga on 15/03/24.
//

import UIKit

class AddViewController: UIViewController,UITextFieldDelegate {
@IBOutlet  var FirstTitle: UITextField!
@IBOutlet  var datePicker: UIDatePicker!
@IBOutlet  var idientifier: UITextField!
    
    public var completion: ((String,String,Date)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirstTitle.delegate = self
        idientifier.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(didTapSaveButton))
        
    }
    @objc func didTapSaveButton(){
        if let titletext = FirstTitle.text, !titletext.isEmpty,
           let idientytext = idientifier.text,!idientytext.isEmpty{
            
            let targetDate = datePicker.date
            completion?(titletext, idientytext, targetDate)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
