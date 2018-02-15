//
//  ChatLoginVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 24.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatLoginVC: BackgroundViewController {
    
    @IBOutlet weak var tfEmail: RoundTextField!
    @IBOutlet weak var tfPass: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfEmail.delegate = self
        self.tfPass.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tfEmail.text = "radi@abv.bg"
        self.tfPass.text = "qwe123"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AuthService.instance.isUserLogged {
            self.login()
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if let email = tfEmail.text,
            let pass = tfPass.text,
            email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0,
            pass.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 {
            
            
            let loadingVC = LoadingViewController()
            self.addChildVC(loadingVC)
            
            AuthService.instance.login(email: email,
                                       pass: pass,
                                       completion:
                { [weak self] (success, message) in
                    loadingVC.removeAsChild()
                    if success {
                        self?.login()
                    }
                    else {
                        self?.showAlert(title: "Login error", message: message)
                        self?.tfEmail.becomeFirstResponder()
                    }
            })
        }
        else {
            self.showAlert(title: "Missing input")
            self.tfEmail.becomeFirstResponder()
        }
    }
    
    func login() {
        self.tfEmail.resignFirstResponder()
        self.tfPass.resignFirstResponder()
        self.present(vc: ChatHomeVC.self)
    }
    
    @IBAction func onRegister(_ sender: Any) {
        self.present(vc: ChatRegisterVC.self, push: false)
    }
    
    @objc func handleTap(guesture: UITapGestureRecognizer) {
        self.tfEmail.resignFirstResponder()
        self.tfPass.resignFirstResponder()
    }
}

extension ChatLoginVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.tfEmail {
            self.tfPass.becomeFirstResponder()
        }
        else {
            self.tfPass.resignFirstResponder()
            self.onLogin(UIButton())
        }
        
        return true
    }
}
