//
//  CocktailRecipeShare.swift
//  Martini
//
//  Created by RONICK on 2021/09/26.
//

import UIKit
import Firebase

extension UploadRecipeViewController {
    
    @objc func btnShareRecipe(_ sender: UIButton) {
        
        guard validate() else { return }

        guard let name = self.cocktailName.text else { return }
        guard let description = self.cocktailDescription.text else { return }
        guard let abv = self.alcoholByVolume.text else { return }
        
        guard let cocktailImage = self.cocktailImage else {
            alert("칵테일 이미지를 선택하세요.")
            return
        }
        
        let recipeData: [String] = vStack_steps.arrangedSubviews.map { subView in
            (subView as! RecipeTextView).recipeTextView.text
        }
        
        ImageUploader.uploadImage(image: cocktailImage, type: .cocktail) { [weak self] imageUrl, error in
            
            if let error = error as NSError? {
                let storageErrorCode = StorageErrorCode.init(rawValue: error.code)
                switch storageErrorCode {
                case .downloadSizeExceeded: self?.alert("사진의 크기가 너무 큽니다.")
                case .invalidArgument: self?.alert("잘못된 파일 형식입니다.")
                default: self?.alert("관리자에게 문의하세요.")
                }
            }
            
            guard let url = imageUrl else { return }
            guard let dataStore_cocktail = DATASTORE_COCKTAIL else { return }
            
            
            guard let base = dataStore_cocktail.base else { return }
            let newCocktail = Cocktail(
                name: name,
                imgUrl: url,
                abv:  Double(abv) ?? 0,
                description: description,
                recipe: recipeData,
                ingredients: dataStore_cocktail.ingredients,
                base: base,
                color: dataStore_cocktail.color.isEmpty ? [Cocktail.Color.none] : dataStore_cocktail.color,
                taste: dataStore_cocktail.taste
            )
            
            CocktailManager.shared.registerCocktail(cocktail: newCocktail) { success, error in
                if let error = error {
                    print("ERROR: \(error.localizedDescription)")
                    return
                }
                
                // 칵테일 등록 후 칵테일 패치
                CocktailManager.shared.fetchAllCocktail { }
                
                // 메인화면으로 전환
                self?.tabBarController?.selectedIndex = 0
            }
        }
        
    }
    
    func validate() -> Bool {
        
        if !self.cocktailName.hasText {
            alert("칵테일 이름을 입력하세요.")
            return false
        }
        
        if !self.cocktailDescription.hasText {
            alert("칵테일 소개를 입력하세요.")
            return false
        }
        
        if DATASTORE_COCKTAIL?.selectedBase == false {
            alert("베이스를 선택해주세요.")
            return false
        }
        
        if DATASTORE_COCKTAIL?.selectedTaste == false {
            alert("맛을 선택해주세요.")
            return false
        }
        
        if DATASTORE_COCKTAIL?.selectedIngredient == false {
            alert("재료를 선택해주세요.")
            return false
        }
        
        if !self.alcoholByVolume.hasText {
            alert("알콜 도수를 입력하세요.")
            return false
        }
        
        if Double(self.alcoholByVolume.text!) == nil {
            alert("알콜 도수는 숫자만 입력해주세요.")
            return false
        }
        
        for step in vStack_steps.arrangedSubviews {
            if (step as! RecipeTextView).recipeTextView.text.isEmpty {
                alert("모든 레시피를 입력해주세요.")
                return false
            }
        }
        
        return true
    }
}
