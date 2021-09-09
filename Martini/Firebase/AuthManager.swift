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
    
    // 회원가입 (Create)
    func registerUser(user: User, password: String, _ completion: @escaping((_ success:Bool, _ error: Error?) -> Void)) {
        
        // 계정 생성(등록)
        Auth.auth().createUser(withEmail: user.email, password: password) { result, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            
            guard let userSession = result?.user else {
                completion(false, nil)
                return
            }
            
            let uid = userSession.uid
            
            do { // 유저 데이터 생성
                try COLLECTION_USERS.document(uid).setData(from: user, encoder: Firestore.Encoder()) { error in
                    if let error = error { // 실패시 위에서 등록했던 유저 계정 삭제
                        print("DEBUG: \(error.localizedDescription)")
                        userSession.delete { error in print("DEBUG: Deleted user..!") }
                        completion(false, error)
                        return
                    }
                    
                    COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                        if let error = error { // 실패시 위에서 등록했던 유저 계정 삭제
                            print("DEBUG: \(error.localizedDescription)")
                            userSession.delete { error in print("DEBUG: Deleted user..!") }
                            completion(false, error)
                            return
                        }
                        
                        // 회원가입한 유저 데이터 가져오기
                        guard let user = try? snapshot?.data(as: User.self) else {
                            userSession.delete { error in print("DEBUG: Deleted user..!") }
                            completion(false, error)
                            return
                        }
                        
                        self.userSession = userSession // 현재 유저 세션 등록
                        self.currentUser = user
                        
                        completion(true, nil)
                        print("Successfully registered user..!")
                        print("currentUser: \(self.currentUser!)")
                    }
                }
            } catch {
                print("DEBUG: \(error.localizedDescription)")
                userSession.delete { error in print("DEBUG: Deleted user..!") }
                completion(false, error)
            }
        }
    }
    
    
    // 회원정보 수정 (Update)
    func updateUser(updatedUser: User, password: String?, _ completion: @escaping ((_ success: Bool, _ error: Error?) -> Void)) {
        
        guard let currentEmail = userSession?.email else { return }
        let credential = EmailAuthProvider.credential(withEmail: currentEmail, password: password ?? "")
        
        // 입력한 비밀번호가 맞는지 재인증하기
        self.userSession?.reauthenticate(with: credential) { result, error in
            if let error = error {
                print("Error: Failed to reauthenticate user.. \(error.localizedDescription)")
                completion(false, error)
                return
            }
        
            if updatedUser.email != currentEmail {
                // 이메일 변경
                self.userSession?.updateEmail(to: updatedUser.email) { error in
                    if let error = error {
                        print("Error: failed to update Email.. \(error.localizedDescription)")
                        completion(false, error)
                        return
                    }
                    
                    self.updateUserData(updatedUser: updatedUser, completion)
                }
            } else {
                self.updateUserData(updatedUser: updatedUser, completion)
            }
            
        }
    }
    
    // 회원 삭제 (Delete)
    func deleteUser(_ completion: @escaping ((_ success: Bool, _ error: Error?) -> Void)) {
        
        guard let uid = userSession?.uid else { return }
        
        // 유저 데이터 삭제
        COLLECTION_USERS.document(uid).delete { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            
            
            // 유저 계정 삭제
            self.userSession?.delete { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    guard let currentUser = self.currentUser else { return }
                    
                    do { // 계정 삭제 실패하면 데이터도 다시 복구하기
                        try COLLECTION_USERS.document(uid)
                            .setData(from: currentUser, encoder: Firestore.Encoder()) { error in
                                if let error = error {
                                    print("Error: failed to restore user data..!")
                                    completion(false, error)
                                    return
                                }
                            }
                    } catch {
                        print("Error: \(error.localizedDescription)")
                        completion(false, error)
                    }
                    
                    completion(false, error)
                    return
                }
                
                print("Successfully deleted user..!")
                
                self.currentUser = nil
                self.userSession = nil
                completion(true, nil)
            }
        }
    }
    
    // 로그인
    func login(email: String, password: String, _ completion: @escaping((_ success:Bool, _ error: Error?) -> Void)) {
        
        // 로그인 하기
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            
            guard let userSession = result?.user else {
                completion(false, error)
                return
            }
            
            
            let uid = userSession.uid
            
            // 로그인 유저 데이터 가져오기
            COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    completion(false, error)
                    return
                }
                
                guard let user = try? snapshot?.data(as: User.self) else {
                    completion(false, error)
                    return
                }
                
                self.userSession = userSession //현재 유저 세션 등록
                self.currentUser = user
                
                completion(true, nil)
                print("Successfully signed in")
                print("user:  \(user)")
            }
        }
    }
    
    
    // 로그아웃
    func logout(_ completion: @escaping ((_ success: Bool, _ error: Error?) -> Void)) {
        
        do{
            try Auth.auth().signOut()
            
            self.userSession = nil
            self.currentUser = nil
            
            print("succssfully signed out")
            
            completion(true, nil)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            completion(false, error)
        }
        
    }
    
    func updateUserData(updatedUser: User, _ completion: @escaping ((_ success: Bool, _ error: Error?) -> Void)) {
        guard let uid = self.userSession?.uid else { return }
        guard let user = self.currentUser else { return }
        
        do { // 유저 데이터 갱신
            try COLLECTION_USERS.document(uid).setData(from: updatedUser, encoder: Firestore.Encoder()) { error in
                if let error = error {
                    print("Error: failed to set user data.. \(error.localizedDescription)")
                    
                    if updatedUser.email != user.email {
                        // 데이터를 업데이트하는데 실패하면 앞서 변경했던 이메일 계정도 다시 되돌림
                        self.userSession?.updateEmail(to: user.email){ error in
                            completion(false, error)
                            return
                        }
                    }
                    
                    completion(false, error)
                    return
                }
                
                self.currentUser = updatedUser
                completion(true, nil)
            }
        } catch { // 데이터를 업데이트하는데 실패하면 앞서 변경했던 이메일 계정도 다시 되돌림
            print("Error: catched error.. \(error.localizedDescription)")
            if updatedUser.email != user.email {
                self.userSession?.updateEmail(to: user.email){ error in
                    completion(false, error)
                    return
                }
            }
            completion(false, error)
            return
        }
    }
}
