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
        
        // 계정 생성(등록)
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
            
            do {
                try COLLECTION_USERS.document(uid).setData(from: user, encoder: Firestore.Encoder()) { error in
                    if let error = error { // 실패시 위에서 등록했던 유저 계정 삭제
                        print("DEBUG: \(error.localizedDescription)")
                        userSession.delete { error in print("DEBUG: Deleted user..!") }
                        completion(false)
                        return
                    }
                    
                    COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                        if let error = error { // 실패시 위에서 등록했던 유저 계정 삭제
                            print("DEBUG: \(error.localizedDescription)")
                            userSession.delete { error in print("DEBUG: Deleted user..!") }
                            completion(false)
                            return
                        }
                        
                        guard let user = try? snapshot?.data(as: User.self) else {
                            userSession.delete { error in print("DEBUG: Deleted user..!") }
                            completion(false)
                            return
                        }
                        
                        self.userSession = userSession // 현재 유저 세션 등록
                        self.currentUser = user
                        
                        completion(true)
                        print("Successfully registered user..!")
                        print("currentUser: \(self.currentUser!)")
                    }
                }
            } catch {
                print("DEBUG: \(error.localizedDescription)")
                userSession.delete { error in print("DEBUG: Deleted user..!") }
                completion(false)
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
            
            guard let userSession = result?.user else {
                completion(false)
                return
            }
            
            let uid = userSession.uid
            
            COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let user = try? snapshot?.data(as: User.self) else {
                    completion(false)
                    return
                }
                
                self.userSession = userSession //현재 유저 세션 등록
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
        
        do{
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
        
    }
}
