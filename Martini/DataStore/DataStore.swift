//
//  PreferenceDataStore.swift
//  Martini
//
//  Created by RONICK on 2021/08/30.
//

import UIKit

struct DataStore {
    
    var user: User?
    
    // 현재 유저의 선호도 데이터 가져오기
    mutating func initializeUserPreference(user: User) {
        self.user = user
        
        
        // 아무것도 선택하지 않았으면 초기화
        if self.user?.basePreference == nil {
            self.user?.basePreference = [Cocktail.Alcohol] ()
        }
        
        if self.user?.ingredientPreference == nil {
            self.user?.ingredientPreference = [Cocktail.Ingredients] ()
        }
        
        // taste 같은 경우는 모든 맛의 선호도를 반드시 가지고 있어야 하므로
        if self.user?.tastePreference == nil {
            self.user?.tastePreference = [String:Int] ()
            for tasteType in Cocktail.Taste.allCases {
                self.user?.tastePreference?.updateValue(0, forKey: tasteType.rawValue)
            }
        }
    }
}

var DATASTORE = DataStore()
