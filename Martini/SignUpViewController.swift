//
//  SignUpViewController.swift
//  Martini
//
//  Created by 이상현 on 2021/08/19.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate, LoginButtonDelegate {
    func signup() {
        
    }
    
    func phone() {
        print(1)
            }
    
    func didTouchLoginButton(didClicked: Bool) {
//        if phoneCertifyButton.isClicked == true {
//            let certifyPhoneVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "CertifyPhoneVC")
//            //        certifyPhoneVC.modalPresentationStyle = .fullScreen
//            present(certifyPhoneVC, animated: true)
//
//        }
//        if signUpButton.isClicked == true {
//            print(1)
//            if flag == true {
//                print(nameTextField.text!, nickNameTextField.text!, emailTextField.text!, passwordTextField.text!)
//            }
//        }
    }
    
    
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
//        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    let nameTextField: CustomInputTextField = {
        let textField = CustomInputTextField()
        textField.informTextInfo(placeholder: "이름", iconName: "person.fill")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let nickNameTextField: CustomInputTextField = {
        let textField = CustomInputTextField()
        textField.informTextInfo(placeholder: "닉네임", iconName: "person")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let phoneCertifyButton: LoginButton = {
        let button = LoginButton()
        button.informTextInfo(text: "휴대폰 인증하기", fontSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailTextField: CustomInputTextField = {
        let textField = CustomInputTextField()
        textField.informTextInfo(placeholder: "이메일", iconName: "envelope.fill")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: CustomInputTextField = {
        let textField = CustomInputTextField()
        textField.informTextInfo(placeholder: "비밀번호", iconName: "lock.fill")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let passwordCheckTextField: CustomInputTextField = {
        let textField = CustomInputTextField()
        textField.informTextInfo(placeholder: "비밀번호 확인", iconName: "lock")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let signUpButton: LoginButton = {
        let button = LoginButton()
        button.informTextInfo(text: "회원가입", fontSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
        self.nameTextField.becomeFirstResponder()
        print(type(of: self), #function)
    }
    // 뷰가 생성되기 전에 레이아웃을 수정하는 방법
    override func viewDidLayoutSubviews() {
        self.containerView.transform = CGAffineTransform(translationX: 0, y: imageStackView.frame.minY)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        containerView.addSubview(imageStackView)
        containerView.addSubview(nameTextField)
        containerView.addSubview(nickNameTextField)
        containerView.addSubview(phoneCertifyButton)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(passwordCheckTextField)
        containerView.addSubview(signUpButton)
        imageStackView.addArrangedSubview(textMartiniImageView)
        imageStackView.addArrangedSubview(martiniImageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imageStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
//            imageStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
//            imageStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            imageStackView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            imageStackView.heightAnchor.constraint(equalToConstant: 80),
            nameTextField.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nickNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
//            nickNameTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -300),
            nickNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nickNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 40),
            phoneCertifyButton.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 40),
            phoneCertifyButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            phoneCertifyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            phoneCertifyButton.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.topAnchor.constraint(equalTo: phoneCertifyButton.bottomAnchor, constant: 40),
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
            signUpButton.topAnchor.constraint(equalTo: passwordCheckTextField.bottomAnchor, constant: 40),
            signUpButton.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor, constant: -200),
            signUpButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        nameTextField.delegate = self
        nickNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
        signUpButton.delegate = self
        
        phoneCertifyButton.delegate = self
        passwordTextField.informTextInfo(placeholder: "비밀번호", iconName: "lock.fill")
        passwordCheckTextField.informTextInfo(placeholder: "비밀번호 확인", iconName: "lock")
        phoneCertifyButton.informTextInfo(text: "휴대폰 인증하기", fontSize: 30)
        signUpButton.informTextInfo(text: "회원가입", fontSize: 30)
        passwordTextField.isSecureTextEntry = true // https://fastutlego.tistory.com/86
        passwordCheckTextField.isSecureTextEntry = true // https://fastutlego.tistory.com/86
        swipeRecognizer()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
        print(type(of: self), #function)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
        print(type(of: self), #function)
    }
    
    func certifyButton(sender: LoginButton){
        if phoneCertifyButton.isSelected == true {
            print(2)
            let certifyPhoneVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "CertifyPhoneVC")
            //        certifyPhoneVC.modalPresentationStyle = .fullScreen
            present(certifyPhoneVC, animated: true)
        } else if signUpButton.isSelected == true {
            print(1)
            if flag == true {
                print(nameTextField.text!, nickNameTextField.text!, emailTextField.text!, passwordTextField.text!)
            }

        }
    }
    
    
    
    
 
    

    // 터치가 발생할때 핸들러 캐치
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true) // todo...
        }
        sender.cancelsTouchesInView = false
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
            //                    self.navigationController?.popViewController(animated: true)
            default: break
            }
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        CheckForSignup()
    }
    
    // 리턴을 눌렀을 때 작동하는 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        emailTextField.resignFirstResponder()
        switch textField {
        case nameTextField:
            nickNameTextField.becomeFirstResponder()
        case nickNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordCheckTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
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
//            bottomConstraint.constant = keyboardHeight - self.view.safeAreaInsets.bottom
            if nameTextField.isEditing == true || nickNameTextField.isEditing == true {
                
                self.containerView.transform = CGAffineTransform(translationX: 0, y: +signUpButton.bounds.height)
            } else if emailTextField.isEditing == true || passwordTextField.isEditing == true || passwordCheckTextField.isEditing == true {
                self.containerView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
//                keyboardAnimate(keyboardRectangle: keyboardFrame, textField: nickNameTextField)
            }

            // 오토레이아웃 맨 밑의 값을 변경해준다.
            // greater than으로 설정하는게 좋을 듯..?
        })
        self.view.layoutIfNeeded()
//         애니메이션이 필요하다면
//        self.view.setNeedsLayout()
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
//            self.bottomConstraint.constant = self.view.safeAreaInsets.bottom
            self.containerView.transform = .identity
//            self.scrollView.frame.origin.y = self.view.bounds.origin.y
        })
        self.containerView.layoutIfNeeded()
//        self.view.setNeedsLayout()
    }
    
    // 텍스트 필드가 가려졌을 때 키보드의 위치를 조정하는 메소드
       func keyboardAnimate(keyboardRectangle: CGRect ,textField: UITextField){
                if keyboardRectangle.height > (self.containerView.frame.height - textField.frame.maxY){
                    self.containerView.transform = CGAffineTransform(translationX: 0, y: (self.containerView.frame.height - keyboardRectangle.height - textField.frame.maxY))
                }
//           view.frame.origin.y += keyboardRectangle.height - view.frame.height + signupButton.frame.maxY
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
