//
// LoginViewController.swift
// Martini
//
// Created by 이상현 on 2021/08/19.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    var flag: Bool = false
    let imageStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 30
        view.alignment = .center
        view.distribution = .equalCentering
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textMartiniImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "TextMarTiNi"))
        return view
    }()
    
    let martiniImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "martini"))
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        //    view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: CustomInputTextField = {
        let textField = CustomInputTextField()
        textField.informTextInfo(placeholder: "이메일", iconName: "envelope.fill")
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: CustomInputTextField = {
        let textField = CustomInputTextField()
        textField.informTextInfo(placeholder: "비밀번호", iconName: "lock.fill")
        textField.isSecureTextEntry = true // https://fastutlego.tistory.com/86
        textField.textContentType = .oneTimeCode
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: LoginButton = {
        let button = LoginButton()
        button.informTextInfo(text: "로그인", fontSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signupButton: LoginButton = {
        let button = LoginButton()
        button.informTextInfo(text: "회원가입", fontSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        containerView.addSubview(imageStackView)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(loginButton)
        containerView.addSubview(signupButton)
        imageStackView.addArrangedSubview(textMartiniImageView)
        imageStackView.addArrangedSubview(martiniImageView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imageStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            imageStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageStackView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            imageStackView.heightAnchor.constraint(equalToConstant: 80),
            emailTextField.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40),
            signupButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        // delegate
        passwordTextField.delegate = self
        emailTextField.delegate = self
        // button
        loginButton.addTarget(self, action: #selector(LoginButtonHandler(_:)), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(LoginButtonHandler(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    
    @objc func LoginButtonHandler(_ sender: UIButton) {
        if sender == loginButton {
            if flag == true {
                AuthManager.shared.login(email: emailTextField.text!, password: passwordTextField.text!) { success, error in
                    if let error = error as NSError? {
                        let authErrorCode = AuthErrorCode.init(rawValue: error.code)
                        switch authErrorCode {
                        case .wrongPassword:
                            self.alert("비밀번호가 틀렸습니다.")
                        case .userNotFound:
                            self.alert("등록되지 않은 유저입니다.")
                        default:
                            self.alert("관리자에게 문의하세요.")
                        }
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                if ((emailTextField.text?.validateEmail()) == false) {
                    shakeTextField(textField: emailTextField)
                    alert("올바른 이메일을 입력하세요.")
                } else if passwordTextField.text?.validatePassword() == false {
                    shakeTextField(textField: passwordTextField)
                    alert("8글자 이상 입력하세요.(문자 2글자 포함)")
                }
            }
        } else if sender == signupButton {
            let signUpVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC")
            signUpVC.modalPresentationStyle = .fullScreen
            present(signUpVC, animated: true)
        }
    }
    
    // 로그인 조건에 따른 로그인 색을 변화하는 메서드
    func CheckForLogin() {
        guard let emailTextFieldCheck = emailTextField.text?.validateEmail() else { return }
        guard let passwordTextFieldCheck = passwordTextField.text?.validatePassword() else { return }
        if emailTextFieldCheck && passwordTextFieldCheck {
            loginButton.setColor(color: COLOR_MARTINI.button_clickable)
            flag = true
        } else {
            loginButton.setColor(color: COLOR_MARTINI.button_normal)
            flag = false
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        CheckForLogin()
        if textField == passwordTextField {
            textField.isSecureTextEntry = true
        }
    }
    
    // 리턴을 눌렀을 때 작동하는 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //    emailTextField.resignFirstResponder()
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            emailTextField.resignFirstResponder()
            LoginButtonHandler(loginButton)
        default:
            view.endEditing(true)
            LoginButtonHandler(loginButton)
        }
        return true
    }
    
    // 화면을 터치했을 때 키보드가 내려가는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
        // Curve
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        // userInfo가 있다면 keyboardFrameEndUserInfoKey를 이용해서 값을 가져온다. {{0, 553}, {390, 291}}
        let keyboardHeight = keyboardFrame.size.height
        UIView.animate(withDuration: duration, delay: 0, options: [UIView.AnimationOptions(rawValue: curve)], animations: { [self] in
            // 키보드의 애니메이션의 값을 가져와서 화면이 움직이는 속도를 동기화해준다.
            //      bottomConstraint.constant = keyboardHeight - self.view.safeAreaInsets.bottom
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + containerView.bounds.maxY - signupButton.frame.maxY)
        }
        )
        self.view.layoutIfNeeded()
        //     애니메이션이 필요하다면
        //    self.view.setNeedsLayout()
        // 성능이 중요하다면
    }
    
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    // NS_을 사용할 때는 objc
    @objc func keyboardWillHide(_ notification: NSNotification){
        let userInfo = notification.userInfo
        // NSNumber로 가져와 값의 형태를 바꿔줄 수도 있다.
        let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
        let curve = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
        UIView.animate(withDuration: duration.doubleValue, delay: 0, options: [UIView.AnimationOptions(rawValue: UInt(curve.intValue))], animations: {
            //      self.bottomConstraint.constant = self.view.safeAreaInsets.bottom
            self.containerView.transform = .identity
            //      self.scrollView.frame.origin.y = self.view.bounds.origin.y
        })
        self.containerView.layoutIfNeeded()
        //    self.view.setNeedsLayout()
    }
    
    func shakeTextField(textField: CustomInputTextField) -> Void{
        UIView.animate(withDuration: 0.2, animations: {
            textField.frame.origin.x -= 10
            textField.backgroundColor = COLOR_MARTINI.button_clickable
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 20
             }, completion: { _ in
                 UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 10
                    textField.backgroundColor = COLOR_MARTINI.textBox
                })
            })
        })
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
