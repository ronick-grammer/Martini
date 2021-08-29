//
//  PhoneCertifyViewController.swift
//  Martini
//
//  Created by 이상현 on 2021/08/19.
//

import UIKit

class CertifyPhoneViewController: UIViewController {
    var keyHeight: CGFloat?

    @IBOutlet var inputPhoneNumber: CustomInputTextField!
    @IBOutlet var certification: LoginButton!
    @IBOutlet var securityCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputPhoneNumber.informTextInfo(placeholder: "휴대전화번호", iconName: "phone.fill")
        
        certification.informTextInfo(text: "인증", fontSize: 30)
        securityCodeTextField.textContentType = .oneTimeCode
        securityCodeTextField.textAlignment = .center
        // Do any additional setup after loading the view.
        
        securityCodeTextField.addTarget(self, action: #selector(test), for: .editingChanged)
        swipeRecognizer()
    }
    
    @objc func test() {
        guard let textW: String = securityCodeTextField.text else { return }
        if textW.count > 1 {
            securityCodeTextField.text = String(textW[textW.index(textW.startIndex, offsetBy: 0)])
        }
    }
    
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
                default: break
                }
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
