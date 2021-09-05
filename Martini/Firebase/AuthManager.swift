//
//  AuthViewController.swift
//  Martini
//
//  Created by RONICK on 2021/08/31.
//

import Firebase

class AuthManager {
    var userSession: FirebaseAuth.User?
    var currentUser: User?
    
    static var shared = AuthManager()
    
    private init() {
        userSession = Auth.auth().currentUser
    }
    
    // 회원가입
    func registerUser(user: User, password: String, _ completion: @escaping((_ success:Bool) -> Void)) {
        
        Auth.auth().createUser(withEmail: user.email, password: password) { result, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let userSession = result?.user else {
                completion(false)
                return
            }
            
            let uid = userSession.uid
            
            let data = [
                "email": user.email,
                "nickName": user.nickName,
                "phone": user.phone,
                "joinDate": Timestamp.init(date: Date())
            ] as [String : Any]
            
            COLLECTION_USERS.document(uid).setData(data) { error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                    if let error = error {
                        print("DEBUG: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    
                    self.userSession = userSession
                    
                    guard let user = try? snapshot?.data(as: User.self) else {
                        completion(false)
                        return }
                    self.currentUser = user
                    
                    completion(true)
                    print("Successfully registered user..!")
                }
            }
        }
    }
    
    
    // 로그인
    func login(email: String, password: String, _ completion: @escaping((Bool) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let userSession = result?.user else { return }
            
            let uid = userSession.uid
            
            COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                self.userSession = userSession
                
                guard let user = try? snapshot?.data(as: User.self) else { return }
                self.currentUser = user
                
                completion(true)
                print("Successfully signed in")
            }
        }
    }
    
    
    // 로그아웃
    func logout() {
        self.userSession = nil
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
}
