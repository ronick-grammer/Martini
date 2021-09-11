//
//  PreferenceDataStore.swift
//  Martini
//
//  Created by RONICK on 2021/08/30.
//

import UIKit

struct PreferenceDataStore {
    var alcohols: [Bool] = Array(repeating: false, count: Cocktail.Alcohol.allCases.count - 1)
    
    var ingredients: [Bool] = Array(repeating: false, count: Cocktail.Ingredients.allCases.count - 1)
    
    var taste: [Double] = Array(repeating: 0, count: Cocktail.Taste.allCases.count)
    
    // 현재 유저의 선호도 정보를 컬렉션 뷰 데이터로 나타내기 위해 각각 변환
    mutating func setPreferenceDataStore() {
        if AuthManager.shared.userSession != nil {
            guard let user = AuthManager.shared.currentUser else { return }
            
            user.basePreference?.forEach({
                alcohols[$0.index] = true
            })
            
            user.ingredientPreference?.forEach({
                ingredients[$0.index] = true
            })
            
            user.tastePreference?.forEach({
                guard let index = Cocktail.Taste.init(rawValue: $0.key)?.index else { return }
                taste[index] = Double($0.value)
            })
        }
    }
    
//    func getPreferenceFetchedUser() -> User? {
//        var bases = [Cocktail.Alcohol] ()
//        var tastes = [Cocktail.Taste:Int]()
//        var ingredients = [Cocktail.Ingredients] ()
//
//        for index in 0 ..< self.alcohols.count {
//            if self.alcohols[index] {
//                bases.append(Cocktail.Alcohol.allCases[index])
//            }
//        }
//
//        for index in 0 ..< self.ingredients.count {
//            if self.ingredients[index] {
//                ingredients.append(Cocktail.Ingredients.allCases[index])
//            }
//        }
//
//        for index in 0 ..< self.taste.count {
//            tastes.updateValue(Int(self.taste[index]), forKey: Cocktail.Taste.allCases[index])
//        }
//
//        guard var user = AuthManager.shared.currentUser else { return nil}
//        user.basePreference = bases
//        user.ingredientPreference = ingredients
//        user.tastePreference = tastes
//
//        return user
//    }
}

var PREFERENCE_DATASTORE = PreferenceDataStore()
