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
        
        emailTextField.InformTextInfo(placeholder: "이메일", iconName: "envelope.fill")
        passwordTextField.InformTextInfo(placeholder: "비밀번호", iconName: "lock.fill")
        loginButton.InformTextInfo(text: "로그인", fontSize: 30)
        signUpButton.InformTextInfo(text: "회원가입", fontSize: 30)
        
    }
    @IBAction func Button(_ sender: UIButton) {
        print("1")
        performSegue(withIdentifier: "sgSignUp", sender: self)
    }
    
    @IBAction func SignUpButton(_ sender: LoginButton) {
        print("1")
        performSegue(withIdentifier: "sgSignUp", sender: self)

    }
//    @IBAction func SignUpButton(_ sender: LoginButton) {
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        let LoginViewController = segue.destination as! SignUpViewController
//        
//        if segue.identifier == "sgSignUp" {
//            // Get the new view controller using segue.destination.
//            // Pass the selected object to the new view controller.
//        }
//    }
    
}
