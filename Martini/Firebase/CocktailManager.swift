//
//  CocktailController.swift
//  Martini
//
//  Created by RONICK on 2021/09/04.
//

import Firebase
import FirebaseFirestoreSwift
import UIKit

class CocktailManager {
    
    var cocktails:[Cocktail] = []
    var filteredCocktails =  [Cocktail] ()
    
    static let shared = CocktailManager()
    private init() {}
    
    // 칵테일 정보 등록
    func registerCocktail(cocktail: Cocktail, _ completion: @escaping(_ success: Bool) -> Void) {
        do{
            
            try COLLECTION_COCKTAILS.document(cocktail.id).setData(from: cocktail, encoder: Firestore.Encoder()) { error in
           
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
    func fetchAllCocktail( complete: @escaping ()->()) {
        COLLECTION_COCKTAILS.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            self.cocktails = documents.compactMap({ try? $0.data(as: Cocktail.self) })
            
            complete()
            
        }
    }
    
    func updateCocktail(cocktail: Cocktail, _ completion: @escaping (_ success: Bool,_ error: Error?) -> Void){
        
        do {
            try COLLECTION_COCKTAILS.document(cocktail.id).setData(from: cocktail, encoder: Firestore.Encoder()) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    completion(false, error)
                    return
                }
                
                completion(true, nil)
            }
            
        } catch {
            print("Error: \(error.localizedDescription)")
            completion(false, nil)
        }
    }
    
    func deleteCocktail(cocktail: Cocktail, _ completion: @escaping (_ success: Bool,_ error: Error?) -> Void) {
        COLLECTION_COCKTAILS.document(cocktail.id).delete { error in
            if let error = error {
                print("Error: Failed to delete a cocktail")
                completion(false, error)
                return
            }
            
            completion(true, nil)
            print("Successfully deleted a cocktail..!")
        }
    }
    
    func filterAbv(abv: Double, _ completion: @escaping ((_ success: Bool, _ error: Error?) -> Void)) {
 
        COLLECTION_COCKTAILS.whereField("abv", isLessThanOrEqualTo: abv).getDocuments { snapshot, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false, error)
                return
            }
            
            do {
                guard let documents = snapshot?.documents else { return }
                self.filteredCocktails = try documents.compactMap({ snapshot in
                    try snapshot.data(as: Cocktail.self)
                })
                
                completion(true, nil)
            } catch {
                print("Error \(error.localizedDescription)")
                completion(true, error)
            }
        }
        
    }
    
    // 랜덤 칵테일 하나 반환
    func fetchRandomCocktailInfo() -> Cocktail {
        
        let random = Int.random(in: 0...cocktails.count-1)
        
        let target = cocktails[random]
            
        return target
    }

}
