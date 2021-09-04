//
//  UserModel.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/12.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
    
    @DocumentID var id: String?
    let nickName: String
    let email: String
    let phone: String
    let liked: [String]
    let joinDate: Timestamp
    
    
    var basePreference: [Cocktail.Alcohol]?
    var ingredientPreference: [Cocktail.Ingredients]?
    var tastePreference: [Cocktail.Taste:Int]?
}
