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
    
    var taste: [Double] = Array(repeating: 0, count: Cocktail.Taste.allCases.count - 1)
    
    // 현재 유저의 선호도 정보를 컬렉션 뷰 데이터로 나타내기 위해 각각 변환
    mutating func setPreferenceDataStore() {
        if AuthController.shared.userSession != nil {
            guard let user = AuthController.shared.currentUser else { return }
            
            user.basePreference?.forEach({
                alcohols[$0.index] = true
            })
            
            user.ingredientPreference?.forEach({
                ingredients[$0.index] = true
            })
            
            user.tastePreference?.forEach({
                taste[$0.key.index] = Double($0.value)
            })
        }
    }
}

var PREFERENCE_DATASTORE = PreferenceDataStore()
