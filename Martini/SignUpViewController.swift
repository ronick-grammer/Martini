//
//  SignUpViewController.swift
//  Martini
//
//  Created by 이상현 on 2021/08/19.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet var nameTextField: CustomInputTextField!
    @IBOutlet var nickNameTextField: CustomInputTextField!
    @IBOutlet var phoneCertifyButton: LoginButton!
    @IBOutlet var passwordTextField: CustomInputTextField!
    @IBOutlet var passwordCheckTextField: CustomInputTextField!
    @IBOutlet var signUpButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.InformTextInfo(placeholder: "이름", iconName: "person.fill")
        nickNameTextField.InformTextInfo(placeholder: "닉네임", iconName: "person")
        passwordTextField.InformTextInfo(placeholder: "비밀번호", iconName: "lock.fill")
        passwordCheckTextField.InformTextInfo(placeholder: "비밀번호 확인", iconName: "lock")
        phoneCertifyButton.InformTextInfo(text: "휴대폰 인증하기", fontSize: 30)
        signUpButton.InformTextInfo(text: "회원가입", fontSize: 30)
        // Do any additional setup after loading the view.
    }
    @IBAction func button(_ sender: UIButton) {
        performSegue(withIdentifier: "sgCertifyPhone", sender: self)
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
