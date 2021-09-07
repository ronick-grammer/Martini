//
//  CocktailController.swift
//  Martini
//
//  Created by RONICK on 2021/09/04.
//

import Firebase
import FirebaseFirestoreSwift

class CocktailManager {
    var cocktails =  [Cocktail] ()
    
    init() {
        fetchAllCocktail()
    }
    
    // 칵테일 정보 등록
    func registerCocktail(cocktail: Cocktail, _ completion: @escaping(_ success: Bool) -> Void) {
        do{
            guard let uid = cocktail.id else {
                completion(false)
                return
            }
            
            try COLLECTION_COCKTAILS.document(uid).setData(from: cocktail, encoder: Firestore.Encoder()) { error in
           
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                print("successfully registered cocktail..!")
                completion(true)
            }
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            completion(false)
            return
        }
    }
    
    // 모든 칵테일 가져오기
    func fetchAllCocktail() {
        COLLECTION_COCKTAILS.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            self.cocktails = documents.compactMap({ try? $0.data(as: Cocktail.self) })
            
            print("successfully fetched cocktails!!: \(self.cocktails.count)")
        }
    }
}

