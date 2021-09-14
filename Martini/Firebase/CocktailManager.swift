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
            print("Successfully fetched all cocktails..!")
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
    
    // 유저의 맛 선호도와 가장 가까운 칵테일 순으로 정렬
    func orderByTastePreference() -> [Cocktail] {
        
        guard let userTastePreference = AuthManager.shared.currentUser?.tastePreference else {
            return [Cocktail]()
        }
        
        return self.cocktails.sorted { cocktail_A, cocktail_B in
            var sum_A = 0, sum_B = 0
            
            for taste in Cocktail.Taste.allCases {
                guard let userTaste = userTastePreference[taste.rawValue] else { return false }
                guard let cocktailTaste_A = cocktail_A.taste[taste] else { return false }
                guard let cocktailTaste_B = cocktail_B.taste[taste] else { return false }
                
                sum_A += abs(userTaste - cocktailTaste_A)
                sum_B += abs(userTaste - cocktailTaste_B)
            }
            
            return sum_A < sum_B
        }
    }
    
    // 유저가 선호하는 재료를 가장 많이 포함하는 칵테일 순으로 정렬
    func orderByIngredientPreference() -> [Cocktail] {
        
        guard let userIngredientPreference = AuthManager.shared.currentUser?.ingredientPreference else  {
            return [Cocktail] ()
        }
        
        return self.cocktails.sorted { cocktail_A, cocktail_B in
            var count_A = 0, count_B = 0
            
            for ingredient in userIngredientPreference {
                if cocktail_A.ingredients.contains(ingredient) {
                    count_A += 1
                }
                
                if cocktail_B.ingredients.contains(ingredient) {
                    count_B += 1
                }
            }
            
            return count_A > count_B
        }
    }
    
    // 랜덤 칵테일 하나 반환
    func fetchRandomCocktailInfo() -> Cocktail {
        
        let random = Int.random(in: 0...cocktails.count-1)
        
        let target = cocktails[random]
            
        return target
    }

}
