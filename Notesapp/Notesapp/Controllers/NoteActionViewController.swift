//
//  NoteActionViewController.swift
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/25/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

import UIKit

class NoteActionViewController: UIViewController {
    
    static var exitSegueIdentifier = "ReturnToNotes"
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var titleField:UITextField!
    @IBOutlet weak var contentView:UITextView!
    @IBOutlet weak var acceptButton:UIButton!
    
    @IBAction func textFieldDidEndEditing(textField: UITextField) {
        if (validateTextFieldIsNotEmpty(textField)) {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderWidth = 0
        }
    }
    
    fileprivate func validateTextFieldIsNotEmpty(_ textField: UITextField) -> Bool {
        return textField.text?.count == 0
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let wasExpectedIdentifier = identifier == NoteActionViewController.exitSegueIdentifier
        if (wasExpectedIdentifier) {
            if (validateTextFieldIsNotEmpty(titleField)) {
                performNoteAction()
                return true
            } else{
                printRequiredFieldsErrorMessage()
                return false
            }
        }
        return true
    }
    
    fileprivate func performNoteAction() {
    }
    
    fileprivate func printRequiredFieldsErrorMessage() {
        let alert = UIAlertController(title: "Error", message: "Complete los campos requeridos para continuar.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
