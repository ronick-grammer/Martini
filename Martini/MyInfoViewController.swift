//
//  MyInfoViewController.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/09/08.
//

import UIKit

class MyInfoViewController: UIViewController {
    
    static let bundleName = "SettingView"
    static let identfireName = "myInfo"
    
    @IBOutlet weak var nickNameField: CustomInputTextField!
    @IBOutlet weak var emailField: CustomInputTextField!
    @IBOutlet weak var passwordField: CustomInputTextField!
    @IBOutlet weak var confirmPasswordField: CustomInputTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickNameField.placeholder = "변경하실 닉네임을 입력해주세요."
        nickNameField.iconView.image = UIImage(systemName: "person.fill")
        emailField.placeholder = "변경하실 이메일을 입력해주세요."
        emailField.iconView.image = UIImage(systemName: "mail.fill")
        passwordField.placeholder = "비밀번호를 입력해주세요."
        passwordField.iconView.image = UIImage(systemName: "lock")
        passwordField.textContentType = .password
        confirmPasswordField.placeholder = "비밀번호를 한번 더 입력해주세요."
        confirmPasswordField.iconView.image = UIImage(systemName: "lock.fill")
        confirmPasswordField.textContentType = .password
        
        submitButton.layer.cornerRadius = 8

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        print(
            User(id: nil, nickName: nickNameField.text ?? "", email: emailField.text ?? "", phone: "", liked: [], joinDate: nil, basePreference: nil, ingredientPreference: nil, tastePreference: nil)
        )
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
