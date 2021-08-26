//
//  SignUpViewController.swift
//  Martini
//
//  Created by 이상현 on 2021/08/19.
//

import UIKit

class SignUpViewController: UIViewController {
    var flag: Bool = false
    
    @IBOutlet var nameTextField: CustomInputTextField!
    @IBOutlet var nickNameTextField: CustomInputTextField!
    @IBOutlet var phoneCertifyButton: LoginButton!
    @IBOutlet var emailTextField: CustomInputTextField!
    @IBOutlet var passwordTextField: CustomInputTextField!
    @IBOutlet var passwordCheckTextField: CustomInputTextField!
    @IBOutlet var signUpButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange(_:)),
            for: UIControl.Event.editingChanged)
        nickNameTextField.addTarget(self, action: #selector(nickNameTextFieldDidChange(_:)),
            for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)),
            for: UIControl.Event.editingChanged)
        passwordCheckTextField.addTarget(self, action: #selector(passwordCheckTextFieldDidChange(_:)),
            for: UIControl.Event.editingChanged)
        nameTextField.informTextInfo(placeholder: "이름", iconName: "person.fill")
        nickNameTextField.informTextInfo(placeholder: "닉네임", iconName: "person")
        emailTextField.informTextInfo(placeholder: "이메일", iconName: "envelope.fill")
        passwordTextField.informTextInfo(placeholder: "비밀번호", iconName: "lock.fill")
        passwordCheckTextField.informTextInfo(placeholder: "비밀번호 확인", iconName: "lock")
        phoneCertifyButton.informTextInfo(text: "휴대폰 인증하기", fontSize: 30)
        signUpButton.informTextInfo(text: "회원가입", fontSize: 30)
        passwordTextField.isSecureTextEntry = false // https://fastutlego.tistory.com/86
        passwordCheckTextField.isSecureTextEntry = false // https://fastutlego.tistory.com/86
        // Do any additional setup after loading the view.
    }
    @IBAction func nameTextFieldDidChange(_ sender: CustomInputTextField) {
        CheckForSignup()
    }
    
    @IBAction func nickNameTextFieldDidChange(_ sender: CustomInputTextField) {
        CheckForSignup()
    }
    
    @IBAction func emailTextFieldDidChange(_ sender: CustomInputTextField) {
        CheckForSignup()
    }
    
    @IBAction func passwordTextFieldDidChange(_ sender: CustomInputTextField) {
        CheckForSignup()
        passwordTextField.isSecureTextEntry = true // 비밀번호입력시 보안이미지
    }
    
    @IBAction func passwordCheckTextFieldDidChange(_ sender: CustomInputTextField) {
        CheckForSignup()
        passwordCheckTextField.isSecureTextEntry = true // 비밀번호입력시 보안이미지
    }
    
    @IBAction func phoneCertifyButton(_ sender: LoginButton) {
        performSegue(withIdentifier: "sgCertifyPhone", sender: self)
    }
    
    @IBAction func signUpbutton(_ sender: LoginButton) {
        if flag == true {
            print(nameTextField.text!, nickNameTextField.text!, emailTextField.text!, passwordTextField.text!)
            
        }
    }
    
    func CheckForSignup() {
        if nameTextField.text?.count ?? 0 >= 1 && nickNameTextField.text?.count ?? 0 >= 1 && emailTextField.text?.contains("@") == true && passwordTextField.text?.count ?? 0 >= 6 && passwordCheckTextField.text?.count ?? 0 >= 6 && passwordTextField.text == passwordCheckTextField.text{
            signUpButton.setColor(color: #colorLiteral(red: 0.9405087233, green: 0.6196145415, blue: 0.6243818998, alpha: 1))
            flag = true
        } else {
            signUpButton.setColor(color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
            flag = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
