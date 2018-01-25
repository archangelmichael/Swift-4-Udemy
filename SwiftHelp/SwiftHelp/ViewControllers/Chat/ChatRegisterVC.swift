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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                { [unowned self] (success, message) in
                    if success {
                        self.goBack()
                    }
                    else {
                        self.showAlert(title: "Register error", message: message)
                    }
            })
        }
        else {
            self.showAlert(title: "Missing input")
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.goBack()
    }
    
    func goBack() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "unwindToChatLoginVC", sender: nil)
        }
    }
}
