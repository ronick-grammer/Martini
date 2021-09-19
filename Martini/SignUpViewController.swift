//
// SignUpViewController.swift
// Martini
//
// Created by 이상현 on 2021/08/19.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate, LoginButtonDelegate {
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
    
    let nickNameTextField: CustomInputTextField = {
        let textField = CustomInputTextField()
        textField.informTextInfo(placeholder: "닉네임", iconName: "person.fill")
        textField.keyboardType = .namePhonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let phoneNumberTextField: CustomInputTextField = {
        let textField = CustomInputTextField()
        textField.informTextInfo(placeholder: "휴대전화번호", iconName: "phone.fill")
        textField.textContentType = .telephoneNumber
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
    
    let passwordCheckTextField: CustomInputTextField = {
        let textField = CustomInputTextField()
        textField.informTextInfo(placeholder: "비밀번호 확인", iconName: "lock")
        textField.isSecureTextEntry = true // https://fastutlego.tistory.com/86
        textField.textContentType = .oneTimeCode
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        containerView.addSubview(nickNameTextField)
        containerView.addSubview(phoneNumberTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(passwordCheckTextField)
        containerView.addSubview(signupButton)
        imageStackView.addArrangedSubview(textMartiniImageView)
        imageStackView.addArrangedSubview(martiniImageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            imageStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            containerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageStackView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            imageStackView.heightAnchor.constraint(equalToConstant: 80),
            
            nickNameTextField.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 40),
            nickNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nickNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 40),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordCheckTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            passwordCheckTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            passwordCheckTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            passwordCheckTextField.heightAnchor.constraint(equalToConstant: 40),
            
            signupButton.topAnchor.constraint(equalTo: passwordCheckTextField.bottomAnchor, constant: 40),
            signupButton.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -100),
            signupButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            signupButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // delegate
        nickNameTextField.delegate = self
        emailTextField.delegate = self
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
        signupButton.delegate = self
        
        // Do any additional setup after loading the view.
        swipeRecognizer()
        signupButton.addTarget(self, action: #selector(LoginButtonHandler(_:)), for: .touchUpInside)
        passwordTextField.isSecureTextEntry = false
        passwordCheckTextField.isSecureTextEntry = false
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.nickNameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    
    @objc func LoginButtonHandler(_ sender: UIButton) {
        if sender == signupButton {
            print(1)
            if flag == true {
                print(emailTextField)
                print(passwordTextField)
                let user = User(nickName: nickNameTextField.text!, email: emailTextField.text!, phone: phoneNumberTextField.text!)
                AuthManager.shared.registerUser(user: user, password: passwordTextField.text!) { success, error in
                    if let error = error as NSError? {
                        let authErrorCode = AuthErrorCode.init(rawValue: error.code)
                        switch authErrorCode {
                        case .emailAlreadyInUse:
                            self.alert("이미 등록된 이메일 입니다.")
                        default:
                            self.alert("관리자에게 문의하세요.")
                        }
                    }
                    guard let currentUser = AuthManager.shared.currentUser else { return }
                    DATASTORE.initializeUserPreference(user: currentUser)
                    
                    let basepreferenceVC = UIStoryboard(name: "BasePreferenceView", bundle: nil).instantiateViewController(withIdentifier: "basePreference")
                    let navController = UINavigationController.init(rootViewController: basepreferenceVC)
                    navController.setNavigationBarHidden(true,
                                       animated: true)
                    navController.modalPresentationStyle = .fullScreen
                    navController.modalTransitionStyle = .crossDissolve
                    self.present(navController, animated: true, completion: nil)
                }
            } else {
                if nickNameTextField.text!.count == 0 {
                    shakeTextField(textField: nickNameTextField)
                    alert("닉네임을 한 글자이상 입력하세요.")
                } else if phoneNumberTextField.text!.count != 11 {
                    shakeTextField(textField: phoneNumberTextField)
                    alert("전화번호를 - 를 제외한 11글자로 입력해주세요.")
                } else if ((emailTextField.text?.validateEmail()) == false) {
                    shakeTextField(textField: emailTextField)
                    alert("올바른 이메일을 입력하세요.")
                } else if passwordTextField.text?.validatePassword() == false {
                    shakeTextField(textField: passwordTextField)
                    alert("8글자 이상 입력하세요.(문자 2글자 포함)")
                } else {
                    shakeTextField(textField: passwordCheckTextField)
                    alert("같은 비밀번호를 입력해주세요.")
                }
            }
        }
    }
    
    // 스와이프 제스쳐
    func swipeRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                // 스와이프 시, 뒤로가기
                self.dismiss(animated: true, completion: nil)
            //          self.navigationController?.popViewController(animated: true)
            default: break
            }
        }
    }
   
    
    func CheckForSignup() {
        guard let emailTextFieldCheck = emailTextField.text?.validateEmail() else { return }
        guard let passwordTextFieldCheck = passwordTextField.text?.validatePassword() else { return }
        if emailTextFieldCheck && passwordTextFieldCheck && nickNameTextField.text?.count ?? 0 >= 1 && phoneNumberTextField.text?.count ?? 0 == 11 && passwordTextField.text == passwordCheckTextField.text {
            signupButton.setColor(color: #colorLiteral(red: 0.9405087233, green: 0.6196145415, blue: 0.6243818998, alpha: 1))
            flag = true
        } else {
            signupButton.setColor(color: #colorLiteral(red: 0.7194328904, green: 0.8873121142, blue: 0.5935972929, alpha: 1))
            flag = false
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        CheckForSignup()
        
        if textField == passwordTextField || textField == passwordCheckTextField {
            textField.isSecureTextEntry = true
        }
    }
    
    // 리턴을 눌렀을 때 작동하는 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //    emailTextField.resignFirstResponder()
        switch textField {
        case nickNameTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordCheckTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
            LoginButtonHandler(signupButton)
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
        
        // Curvb
        // userInfo가 있다면 keyboardAnimationCurveUserInfoKey를 이용해서 값을 가져온다. 7
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        // userInfo가 있다면 keyboardFrameEndUserInfoKey를 이용해서 값을 가져온다. {{0, 553}, {390, 291}}
        let keyboardHeight = keyboardFrame.size.height
        // {{X, Y},{Width, Height}}
        
        UIView.animate(withDuration: duration, delay: 0, options: [UIView.AnimationOptions(rawValue: curve)], animations: { [self] in
            // 키보드의 애니메이션의 값을 가져와서 화면이 움직이는 속도를 동기화해준다.
            //      bottomConstraint.constant = keyboardHeight - self.view.safeAreaInsets.bottom
            if nickNameTextField.isEditing == true || phoneNumberTextField.isEditing == true {
                self.containerView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + containerView.bounds.maxY - emailTextField.frame.maxY)
            } else if emailTextField.isEditing == true || passwordTextField.isEditing == true || passwordCheckTextField.isEditing == true {
                self.containerView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + containerView.bounds.maxY - signupButton.frame.maxY)
                //        keyboardAnimate(keyboardRectangle: keyboardFrame, textField: nickNameTextField)
            }
            
            // 오토레이아웃 맨 밑의 값을 변경해준다.
            // greater than으로 설정하는게 좋을 듯..?
        })
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
            textField.backgroundColor = #colorLiteral(red: 0.9405087233, green: 0.6196145415, blue: 0.6243818998, alpha: 1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 20
             }, completion: { _ in
                 UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 10
                    textField.backgroundColor = .systemGray5
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
