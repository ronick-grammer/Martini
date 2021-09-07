//
//  UserModel.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/12.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Codable {
    
    @DocumentID var id: String?
    let nickName: String
    let email: String
    let phone: String
    var liked: [String]?
    var joinDate: Timestamp?
    
    var basePreference: [Cocktail.Alcohol]?
    var ingredientPreference: [Cocktail.Ingredients]?
    var tastePreference: [Cocktail.Taste:Int]?
    
    enum CodingKeys : String, CodingKey {
        case id
        case nickName
        case email
        case phone
        case liked
        case joinDate
        case basePreference
        case ingredientPreference
        case tastePreference
    }
}
