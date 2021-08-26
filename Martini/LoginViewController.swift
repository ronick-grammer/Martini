//
//  LoginViewController.swift
//  Martini
//
//  Created by 이상현 on 2021/08/19.
//

import UIKit


class LoginViewController: UIViewController {
    var flag: Bool = false

    @IBOutlet var emailTextField: CustomInputTextField!
    @IBOutlet var passwordTextField: CustomInputTextField!
    @IBOutlet var loginButton: LoginButton!
    @IBOutlet var signupButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addTarget(self, action: #selector(emailTextDIdChange(_:)),
            for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextDIdChange(_:)),
            for: UIControl.Event.editingChanged)
        emailTextField.informTextInfo(placeholder: "이메일", iconName: "envelope.fill")
        passwordTextField.informTextInfo(placeholder: "비밀번호", iconName: "lock.fill")
        loginButton.informTextInfo(text: "로그인", fontSize: 30)
        signupButton.informTextInfo(text: "회원가입", fontSize: 30)

    }
    
    @IBAction func loginButton(_ sender: LoginButton) {
        if flag == true {
            print(emailTextField.text!, passwordTextField.text!)
        }
    }
    
    @IBAction func signupButton(_ sender: LoginButton) {
        let signupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signupVC")
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true)
            }
    
    @IBAction func emailTextDIdChange(_ sender: CustomInputTextField) {
        CheckForSignup()
    }
    
    @IBAction func passwordTextDIdChange(_ sender: CustomInputTextField) {
        CheckForSignup()
        passwordTextField.isSecureTextEntry = true
    }

    func CheckForSignup() {
        if emailTextField.text?.contains("@") == true && passwordTextField.text?.count ?? 0 >= 6 {
            loginButton.setColor(color: #colorLiteral(red: 0.9405087233, green: 0.6196145415, blue: 0.6243818998, alpha: 1))
            flag = true
        } else {
            loginButton.setColor(color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
            flag = false
        }
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        let LoginViewController = segue.destination as! SignUpViewController
//
//        if segue.identifier == "sgSignUp" {
//            // Get the new view controller using segue.destination.
//            // Pass the selected object to the new view controller.
//        }
//    }
}
