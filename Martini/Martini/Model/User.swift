//
//  UserModel.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/12.
//

import Foundation

struct User {
    let nickName: String
    let email: String
    let phone: String
    let liked: [String]
    let joinDate: String
    let preferenceIngredients: [Cocktail.Ingredients]
    let preferenceTaste: Cocktail.Taste
}
