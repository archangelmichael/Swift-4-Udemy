//
//  ChatRegisterVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatRegisterVC: UIViewController {

    @IBOutlet weak var tfName: RoundTextField!
    @IBOutlet weak var tfSurname: RoundTextField!
    @IBOutlet weak var tfEmail: RoundTextField!
    @IBOutlet weak var tfPass: RoundTextField!
    
    var textFields : [UITextField] = []
    var focusedTextField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textFields.append(contentsOf: [self.tfName, self.tfSurname, self.tfEmail, self.tfPass])
        self.setTFDelegates()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tfName.text = nil
        self.tfSurname.text = nil
        self.tfEmail.text = nil
        self.tfPass.text = nil
    }
    
    @IBAction func onRegister(_ sender: Any) {
        if let firstname = tfName.text,
            let lastname = tfSurname.text,
            let email = tfEmail.text,
            let pass = tfPass.text,
            firstname.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0,
            lastname.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0,
            email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0,
            pass.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 {
            
            AuthService.instance.register(firstname: firstname,
                                          lastname: lastname,
                                          email:email,
                                          pass: pass,
                                          completion:
                { [weak self] (success, message) in
                    if success {
                        self?.close()
                    }
                    else {
                        self?.showAlert(title: "Register error", message: message)
                        self?.tfName.becomeFirstResponder()
                    }
            })
        }
        else {
            self.showAlert(title: "Missing input")
            self.tfName.becomeFirstResponder()
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.close()
    }
    
    func setTFDelegates() {
        for tf in self.textFields {
            tf.delegate = self
        }
    }
    
    @objc func handleTap(guesture: UITapGestureRecognizer) {
        if let tf = self.focusedTextField {
            tf.resignFirstResponder()
        }
    }
}

extension ChatRegisterVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.focusedTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.focusedTextField != nil {
            if let tfIndex = self.textFields.index(of: textField),
                tfIndex < self.textFields.count - 1 {
                self.focusedTextField = self.textFields[tfIndex.advanced(by: 1)]
                self.focusedTextField?.becomeFirstResponder()
            }
            else {
                textField.resignFirstResponder()
                self.focusedTextField = nil
                self.onRegister(UIButton())
            }
        }
        
        return true
    }
}
