//
//  Swift+Validation.swift
//  Martini
//
//  Created by 이상현 on 2021/09/19.
//

import Foundation

let EMAIL_REG_EX = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
let PASSWORD_REG_EX = "(?=.*[A-Za-z])(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"

extension String {
    // 이메일 정규식
    func validateEmail() -> Bool {
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", EMAIL_REG_EX)
        return predicate.evaluate(with: self)
    }
    
    // 패스워드
    func validatePassword() -> Bool {//숫자+문자 포함해서 8~20글자 사이의 text 체크하는 정규표현식
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", PASSWORD_REG_EX)
        return passwordtesting.evaluate(with: self) }
}
