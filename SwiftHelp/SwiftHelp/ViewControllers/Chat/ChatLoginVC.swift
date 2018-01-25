//
//  ChatLoginVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 24.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatLoginVC: UIViewController {

    @IBOutlet weak var tfEmail: RoundTextField!
    @IBOutlet weak var tfPass: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tfEmail.text = nil
        self.tfPass.text = nil
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
            
            AuthService.instance.login(email: email,
                                       pass: pass,
                                       completion:
                { [unowned self] (success, message) in
                    if success {
                        self.login()
                    }
                    else {
                        self.showAlert(title: "Login error", message: message)
                    }
            })
        }
        else {
            self.showAlert(title: "Missing input")
        }
    }
    
    func login() {
        self.present(vc: ChatHomeVC.self)
    }
    
    @IBAction func onRegister(_ sender: Any) {
        self.present(vc: ChatRegisterVC.self, push: false)
    }
}
