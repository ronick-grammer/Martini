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
    var likedCocktails = [Cocktail]()
    
    static let shared = CocktailManager()
    private init() {}
    
    // 칵테일 정보 등록
    func registerCocktail(cocktail: Cocktail, _ completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
        
        do{
            
            try _ = COLLECTION_COCKTAILS.addDocument(from: cocktail, encoder: Firestore.Encoder()) { error in
           
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    completion(false, error)
                    return
                }
                
                print("successfully registered cocktail..!")
                
                completion(true, nil)
            }
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            completion(false, error)
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
        
        guard let oid = cocktail.id else { return }
        
        do {
            try COLLECTION_COCKTAILS.document(oid).setData(from: cocktail, encoder: Firestore.Encoder()) { error in
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
        guard let cocktailID = cocktail.id else { return }
        
        COLLECTION_COCKTAILS.document(cocktailID).delete { error in
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
    
    func filterCocktail(base: Cocktail.Alcohol) -> [Cocktail] {
        return cocktails.filter { $0.base == base }
    }
    
    func filterCocktail(ingredients: Cocktail.Ingredients) -> [Cocktail] {
        return cocktails.filter {
            $0.ingredients.firstIndex(of: ingredients) != nil
        }
    }
    
    func filterCocktail(taste: Cocktail.Taste) -> [Cocktail] {
        return cocktails.filter {
            let sortedValue = $0.taste.sorted { $0.value > $1.value }
            return sortedValue.first?.key == taste
        }
    }
    
    func filterCocktail(color: Cocktail.Color) -> [Cocktail]{
        return cocktails.filter { $0.color.firstIndex(of: color) != nil }
    }
    
    func filterCocktail(abv: Double) -> [Cocktail]{
        return cocktails.filter { abv - 2 < $0.abv && abv + 2 > $0.abv }
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
    
    func liked(cocktailId: String, _ completion: @escaping (_ completion: Bool, _ error: Error?) -> Void) {
        guard let uid = AuthManager.shared.currentUser?.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-like-cocktail")
            .document(cocktailId).setData([:]) { error in
                
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    completion(false, error)
                    return
                }
                
                completion(true, nil)
        }
    }
    
    func unliked(cocktailId: String, _ completion: @escaping (_ completion: Bool, _ error: Error?) -> Void) {
        guard let uid = AuthManager.shared.currentUser?.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-like-cocktail")
            .document(cocktailId).delete() { error in
                
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    completion(false, error)
                    return
                }
                
                completion(true, nil)
        }
    }
    
    // 유저가 좋아요를 눌렀는지 체크
    func checkIfUserLiked(cocktailID: String, _ completion: @escaping ((isLiked: Bool?, error: Error?)) -> Void)
    {
        
        guard let uid = AuthManager.shared.userSession?.uid else { return }

        COLLECTION_USERS.document(uid).collection("user-like-cocktail")
            .document(cocktailID).getDocument { snapshot, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    completion((nil, error))
                    return
                }
                
                let isLiked = snapshot?.exists
                completion((isLiked, nil))
            }
    }
    
    func fetchLikedCocktails(_ completion: @escaping (_ error: Error?) -> Void) {
        
        guard let uid = AuthManager.shared.currentUser?.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-like-cocktail").getDocuments { snapshot, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            let documents = snapshot?.documents
            
            var count = 0
            self.likedCocktails.removeAll()
            
            documents?.forEach({ snapshot in
                let oid = snapshot.documentID
                
                COLLECTION_COCKTAILS.document(oid).getDocument { snapshot, error in
                    if let error = error {
                        print("ERROR: \(error.localizedDescription)")
                        completion(error)
                        return
                    }
                    
                    do {
                        
                        let cocktail = try snapshot?.data(as: Cocktail.self)
                        
                        self.likedCocktails.append(cocktail!)
                        
                        count += 1
    
                        if count == documents?.count { // 다 찾았으면 완료
                            completion(nil)
                        }
                        
                    } catch {
                        print("ERROR: \(error)")
                        completion(error)
                    }
                }
            })
            
        }
    }
    
}
