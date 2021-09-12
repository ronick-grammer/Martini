//
//  LoginViewController.swift
//  Martini
//
//  Created by 이상현 on 2021/08/19.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    var flag: Bool = false
    @IBOutlet var emailTextField: CustomInputTextField!
    @IBOutlet var passwordTextField: CustomInputTextField!
    @IBOutlet var loginButton: LoginButton!
    @IBOutlet var signupButton: LoginButton!
    
    // 뷰가 생성되기 전에 레이아웃을 수정하는 방법
    override func viewDidLayoutSubviews() {
        self.view.transform = CGAffineTransform(translationX: 0, y: 150)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
        print(type(of: self), #function)
        self.emailTextField.becomeFirstResponder()
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
            AuthManager.shared.login(email: emailTextField.text!, password: passwordTextField.text!) { success, error in
                if let error = error as NSError? {
                    let authErrorCode = AuthErrorCode.init(rawValue: error.code)
                    switch authErrorCode {
                    case .wrongPassword:
                        self.alert("비밀번호가 틀렸습니다.")
                    case .userNotFound:
                        self.alert("등록되지 않은 유저입니다.")
                    case .invalidEmail:
                        self.alert("이메일 형식이 잘못되었습니다.")
                    default:
                        self.alert("관리자에게 문의하세요.")
                    }
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signupButton(_ sender: LoginButton) {
        // 스토리보드를 이용한 화면전환
        let signUpVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC")
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
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
        view.endEditing(true)
        // 키보드를 내려준다.
        // 확실하게 어떤 키보드인지 알고 있다면 textFieldName.resignFirstResponder()을 이용하면 된다.
        // 성능차이는 크게 없음
        if textField == emailTextField {
        // 이메일 텍스트필드 일 때
            passwordTextField.becomeFirstResponder()
            // 패스워드 텍스트필드를 불러온다.
        } else {
        // 패스워드 텍스트필드 일 때
            loginButton(loginButton)
            // 로그인 버튼이 눌러준다.
            
        }
        return true
    }
        
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    // NS_을 사용할 때는 objc
    @objc func keyboardWillShow(_ notification: NSNotification) {
        let userInfo = notification.userInfo
        // 형태가 궁금하다면... 주석 해제
        // print(userInfo)
        let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        // duration 애니메이션이 지속되는 초단위
        // userInfo가 있다면 keyboardAnimationDurationUserInfoKey를 이용해서 값을 가져온다. 0
        let curve = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        // Curvb
        // userInfo가 있다면 keyboardAnimationCurveUserInfoKey를 이용해서 값을 가져온다. 7
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        // userInfo가 있다면 keyboardFrameEndUserInfoKey를 이용해서 값을 가져온다. {{0, 553}, {390, 291}}
        // {{X, Y},{Width, Height}}
        
        UIView.animate(withDuration: duration, delay: 0, options: [UIView.AnimationOptions(rawValue: curve)], animations: {
            // 키보드의 애니메이션의 값을 가져와서 화면이 움직이는 속도를 동기화해준다.
            self.view.frame.origin.y -= keyboardFrame.height
        })
        self.view.layoutIfNeeded()
        // 애니메이션이 필요하다면
//        self.view.setNeedsLayout()
        // 애니메이션이 나오지는 않지만 성능이 중요하다면
    }
    
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    // NS_을 사용할 때는 objc
    @objc func keyboardWillHide(_ notification: NSNotification){
        let userInfo = notification.userInfo
        // NSNumber로 가져와 값의 형태를 바꿔줄 수도 있다.
        let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
        let curve = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
        
        UIView.animate(withDuration: duration.doubleValue, delay: 0, options: [UIView.AnimationOptions(rawValue: UInt(curve.intValue))], animations: {
            self.view.frame.origin.y = 0
        })
        self.view.layoutIfNeeded()
//        self.view.setNeedsLayout()
    }
    
    
//     // 텍스트 필드가 가려졌을 때 키보드의 위치를 조정하는 메소드
//        func keyboardAnimate(keyboardRectangle: CGRect ,textField: UITextField){
////                if keyboardRectangle.height > (self.view.frame.height - textField.frame.maxY){
////                    self.view.transform = CGAffineTransform(translationX: 0, y: (self.view.frame.height - keyboardRectangle.height - textField.frame.maxY))
////                }
//            view.frame.origin.y += keyboardRectangle.height - view.frame.height + signupButton.frame.maxY
//            }
//
}
////
////  ViewController.swift
////  Martini
////
////  Created by Jingyu Lim on 2021/08/16.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LogInVC")
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
////        self.navigationController?.isNavigationBarHidden = true
////        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
////        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//}
