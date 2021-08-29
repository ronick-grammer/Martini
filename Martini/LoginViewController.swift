//
//  LoginViewController.swift
//  Martini
//
//  Created by 이상현 on 2021/08/19.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate {
    var flag: Bool = false
    
    @IBOutlet var emailTextField: CustomInputTextField!
    @IBOutlet var passwordTextField: CustomInputTextField!
    @IBOutlet var loginButton: LoginButton!
    @IBOutlet var signupButton: LoginButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
        self.emailTextField.becomeFirstResponder()
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        // 키보드 형태
        emailTextField.keyboardType = .emailAddress
        // 자동완성
        emailTextField.textContentType = .emailAddress
        // delegate 사용
        passwordTextField.delegate = self
        emailTextField.delegate = self
        // TextDidChange 동작
        emailTextField.addTarget(self, action: #selector(emailTextDidChange(_:)),
                                 for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextDidChange(_:)),
                                    for: UIControl.Event.editingChanged)
        emailTextField.informTextInfo(placeholder: "이메일", iconName: "envelope.fill")
        passwordTextField.informTextInfo(placeholder: "비밀번호", iconName: "lock.fill")
        loginButton.informTextInfo(text: "로그인", fontSize: 30)
        signupButton.informTextInfo(text: "회원가입", fontSize: 30)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
        print(type(of: self), #function)
    }
    
    // 로그인 버튼 액션
    @IBAction func loginButton(_ sender: LoginButton) {
        if flag == true {
            print(emailTextField.text!, passwordTextField.text!)
        }
    }
    
    @IBAction func signupButton(_ sender: LoginButton) {
        // 스토리보드를 이용한 화면전환
        let signupVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC")
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true)
    }
    
    @IBAction func emailTextDidChange(_ sender: CustomInputTextField) {
        CheckForLogin()
    }
    
    @IBAction func passwordTextDidChange(_ sender: CustomInputTextField) {
        CheckForLogin()
    }
    
    // 화면을 터치했을 때 키보드가 내려가는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // 로그인 조건에 따른 로그인 색을 변화하는 메서드
    func CheckForLogin() {
        if emailTextField.text?.contains("@") == true && passwordTextField.text?.count ?? 0 >= 6 {
            loginButton.setColor(color: #colorLiteral(red: 0.9405087233, green: 0.6196145415, blue: 0.6243818998, alpha: 1))
            flag = true
        } else {
            loginButton.setColor(color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
            flag = false
        }
    }
    
    // 노티피케이션을 추가하는 메서드
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 리턴을 눌렀을 때 작동하는 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        emailTextField.resignFirstResponder()
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
            signupButton(signupButton)
        } else {
//            passwordTextField.resignFirstResponder()
            loginButton(loginButton)
        }
        return true
    }
    
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ notification: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        if emailTextField.isEditing == true {
            view.transform = CGAffineTransform(translationX: 0, y: view.frame.height - keyboardHeight - signupButton.frame.maxY)
            //            keyboardAnimate(keyboardRectangle: keyboardRectangle, textField: emailTextField)
        } else if passwordTextField.isEditing == true {
            view.transform = CGAffineTransform(translationX: 0, y: view.frame.height - keyboardHeight - signupButton.frame.maxY)
        }
    }
    
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        view.transform = .identity
        
    }
    
    // 텍스트 필드가 가려졌을 때 키보드의 위치를 조정하는 메소드
    //    func keyboardAnimate(keyboardRectangle: CGRect ,textField: UITextField){
    //            if keyboardRectangle.height > (self.view.frame.height - textField.frame.maxY){
    //                self.view.transform = CGAffineTransform(translationX: 0, y: (self.view.frame.height - keyboardRectangle.height - textField.frame.maxY))
    //            }
    //        }
}
