//
//  MyInfoViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/09/08.
//

import UIKit
import Firebase

class MyInfoViewController: UIViewController {
    
    static let bundleName = "SettingView"
    static let identfireName = "myInfo"
    
    var user: User? = AuthManager.shared.currentUser
    
    var submitTrigger = false
    
    @IBOutlet weak var nickNameField: CustomInputTextField!
    @IBOutlet weak var emailField: CustomInputTextField!
    @IBOutlet weak var passwordField: CustomInputTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickNameField.placeholder = "변경하실 닉네임을 입력해주세요."
        nickNameField.iconView.image = UIImage(systemName: "person.fill")
        nickNameField.delegate = self
        emailField.placeholder = "변경하실 이메일을 입력해주세요."
        emailField.iconView.image = UIImage(systemName: "mail.fill")
        emailField.delegate = self
        passwordField.placeholder = "비밀번호를 입력해주세요."
        passwordField.iconView.image = UIImage(systemName: "lock")
        passwordField.textContentType = .password
        passwordField.delegate = self
        submitButton.layer.cornerRadius = 8
        
        nickNameField.text = user?.nickName
        emailField.text = user?.email
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: UIButton) {
        guard let nickname = nickNameField.text else {
            alert("닉네임을 입력해 주세요.")
            return
        }
        
        guard let email = emailField.text, isValidEmail(testStr: email) else {
            alert("잘못된 이메일 입니다.")
            return
        }
        
        guard let password = passwordField.text else {
            alert("패스워드를 입력해 주세요")
            return
        }
        
        guard let user = user else {
            alert("로그인정보가 없습니다")
            return
        }
        
        let newUser = User(id: user.id, nickName: nickname, email: email, phone: user.phone, liked: user.liked, joinDate: user.joinDate, basePreference: user.basePreference, ingredientPreference: user.ingredientPreference, tastePreference: user.tastePreference)
        
        AuthManager.shared.updateUser(updatedUser: newUser, password: password) { result, error in
            if error != nil {
                if let error = error as NSError? {
                    
                    switch AuthErrorCode.init(rawValue: error.code) {
                    
                    case .wrongPassword:
                        self.alert("비밀번호가 잘못되었습니다.")
                    default: break
                        
                    }
                    
                }
            }
                    
            if result {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
        
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
          return emailTest.evaluate(with: testStr)
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

extension MyInfoViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        switch textField {
        case nickNameField:
            emailField.becomeFirstResponder()
            return true
        case emailField:
            passwordField.becomeFirstResponder()
            return true
        case passwordField:
            submit(submitButton)
        default:
            break
        }
        return false
    }
}
