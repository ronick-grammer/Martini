//
//  LoginViewController.swift
//  Martini
//
//  Created by 이상현 on 2021/08/19.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var emailTextField: CustomInputTextField!
    @IBOutlet var passwordTextField: CustomInputTextField!
    @IBOutlet var loginButton: LoginButton!
    @IBOutlet var signUpButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveEmailTextInfo()
        savePasswordTextInfo()
        loginButton.textInfo(text: "로그인", fontSize: 30)
        signUpButton.textInfo(text: "회원가입", fontSize: 30)
//        signUpButton.isUserInteractionEnabled = true
        signUpButton.Button.addTarget(self, action: #selector(signUpButton.LoginButtonHandler(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func SignUpButton(_ sender: LoginButton) {
        print("1")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let LoginViewController = segue.destination as! SignUpViewController
        
        if segue.identifier == "sgSignUp" {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
    }
    
    func saveEmailTextInfo() {
        emailTextField.placeholder = "이메일"
        emailTextField.iconView.image = UIImage(systemName: "envelope.fill")
    }
    
    func savePasswordTextInfo() {
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.iconView.image = UIImage(systemName: "lock.fill")
        
    }

}
