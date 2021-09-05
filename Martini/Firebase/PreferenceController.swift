//
//  PreferenceController.swift
//  Martini
//
//  Created by RONICK on 2021/09/02.
//


import Firebase
import FirebaseDatabase

class PreferenceController {
    
    // 유저 선호도 파이어베이스에 저장
    func registerUserPreference(bases: [String], tastes: [String:Int], ingredients: [String]) {
        self.setBasePreference(bases: bases)
        self.setTastePreference(tastes: tastes)
        self.setIngredientPreference(ingredients: ingredients)
    }
    
    // 베이스 선호도 저장
    func setBasePreference(bases: [String]) {
        
        guard let uid = AuthController.shared.userSession?.uid else { return }
        COLLECTION_USERS.document(uid).updateData(["basePreference" : bases]) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
            }
    
            AuthController.shared.currentUser?.basePreference = bases.map({
                Cocktail.Alcohol.init(rawValue: $0) ?? Cocktail.Alcohol.none
            })
        }
    }
    
    // 맛 선호도 저장
    func setTastePreference(tastes: [String:Int]) {
        
        guard let uid = AuthController.shared.userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).updateData(["tastePreference" : tastes]) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
            }
            
            tastes.forEach { key, value in
                AuthController.shared.currentUser?.tastePreference?.updateValue(value, forKey: Cocktail.Taste.init(rawValue: key) ?? Cocktail.Taste.none)
            }
        }
    }
    
    // 재료 선호도 저장
    func setIngredientPreference(ingredients: [String]) {
        
        guard let uid = AuthController.shared.userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).updateData(["ingredientPreference" : ingredients]) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
            }
            
            AuthController.shared.currentUser?.ingredientPreference = ingredients.map({ Cocktail.Ingredients.init(rawValue: $0) ?? Cocktail.Ingredients.none
            })
        }
    }
}


/*
class PreferenceController {
    
    func registerUserPreference(bases: [Int], tastes: [Int], ingredients: [Int]) {
        
        self.setBasePreference(bases: bases, tastes: tastes, ingredients: ingredients)
        
    }
    
    func setBasePreference(bases: [Int], tastes: [Int]?, ingredients: [Int]?) {
        
        guard let uid = AuthController.shared.userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).updateData(["basePreference" : bases]) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
            }
    
            AuthController.shared.currentUser?.basePreference = bases.map({
                Cocktail.Alcohol.init(rawValue: $0) ?? Cocktail.Alcohol.none
            })
            
            if let tastes_unwrapped = tastes, let ingredients_unwrapped = ingredients{
                self.setTastePreference(tastes: tastes_unwrapped, ingredients: ingredients_unwrapped)
            }
        }
    }
    
    func setTastePreference(tastes: [Int], ingredients: [Int]?) {
        
        guard let uid = AuthController.shared.userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).updateData(["tastePreference" : tastes]) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
            }
            
            AuthController.shared.currentUser?.tastePreference = tastes
            
            if let ingredients_unwrapped = ingredients {
                self.setIngredientPreference(ingredients: ingredients_unwrapped)
            }
        }
    }
    
    func setIngredientPreference(ingredients: [Int]) {
        
        guard let uid = AuthController.shared.userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).updateData(["ingredientPreference" : ingredients]) { error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
            }
            
            AuthController.shared.currentUser?.ingredientPreference = ingredients.map({ Cocktail.Ingredients.init(rawValue: $0) ?? Cocktail.Ingredients.none })
            
            self.fetchUserPreferences()
        }
    }
    
    func fetchUserPreferences() {
        guard let uid = AuthController.shared.userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            
            guard let user = try? snapshot?.data(as: User.self) else { return }
        
            print("user: \(user)")
            print("currentUser: \(AuthController.shared.currentUser!)")
            print("Successfully regsitered preferences!")
        }
    }
}
*/
