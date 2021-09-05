//
//  AuthViewController.swift
//  Martini
//
//  Created by RONICK on 2021/08/31.
//

import Firebase

class AuthController {
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    
    static var shared = AuthController()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    // 회원가입
    func registerUser(email: String, password: String, nickName: String, phone: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            let uid = user.uid
            self.userSession = user
            
            let data = [
                "email": email,
                "nickName": nickName,
                "phone": phone,
                "joinDate": Timestamp.init(date: Date())
            ] as [String : Any]
            
            COLLECTION_USERS.document(uid).setData(data) { error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    return
                }
                
                print("Successfully registered user..!")
                
                self.fetchUser()
            }
        }
        
    }
    
    // 로그인
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    // 로그아웃
    func logout() {
        self.userSession = nil
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
    
    // 현재 유저 가져오기
    func fetchUser() {
        
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
            
            //print("user: \(user)")
        }
    }
    
}

