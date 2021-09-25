//
//  ImageUploader.swift
//  Martini
//
//  Created by RONICK on 2021/09/25.
//


import UIKit
import Firebase


enum UploadType {
    case cocktail
    
    var filePath: StorageReference {
        
        let fileName = NSUUID().uuidString
        
        switch self {
        case .cocktail:
            return Storage.storage().reference(withPath: "/cocktail_Image/\(fileName)")
        }
    }
}

struct ImageUploader {
    
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(_ url:String?, _ error:Error?) -> Void) {
        
        // jpeg 사진 퀄리티를 조정한다. 사진 퀄리티는 사진 크기(메모리)와 연관이 있으므로 크게 잡지 않는다.
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        // 파이어베이스 스토리지에 업로드할 사진의 url 주소를 지정한다.
        let ref = type.filePath
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            print("succssfully uploaded image...!")
            
            // 이미지를 업로드한다. 이미지 업로드에 성공하면 그 url 주소를 user 테이블에 저장
            ref.downloadURL { url, error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }
                
                guard let imageUrl = url?.absoluteString else {
                    completion(nil, error)
                    return
                }
                
                completion(imageUrl, error)
            }
                
        }
        
    }
}
