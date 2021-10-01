//
//  Constants.swift
//  Martini
//
//  Created by RONICK on 2021/09/01.
//

import Firebase
import UIKit

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_COCKTAILS = Firestore.firestore().collection("cocktails")

struct COLOR_MARTINI {
    
    static var pink: UIColor { get { return #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1) } }
    static var gray: UIColor { get { return .systemGray5 } }
    
    // MARK: - TextBox
    /// TextField, TextView 배경 색
    static var textBox: UIColor { get { return .systemGray6 } }
    
    // MARK: - 클릭 가능 버튼
    /// UIButton 배경 색, 클릭 가능한 버튼 배경색으로 사용
    static var button_clickable: UIColor { get { return #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1) } }
    
    // MARK: - 일반 버튼
    /// UIButton 배경 색, 일반적인 버튼 색으로 사용
    static var button_normal: UIColor { get { return .systemGray5 } }
    
    // MARK: - 슬라이더 채움 색
    /// UISlider 색, MinimumTrack 색으로 사용
    static var slider_filled: UIColor { get { return #colorLiteral(red: 0.9400233626, green: 0.6212706566, blue: 0.6243276, alpha: 1) } }
    
    // MARK: - 슬라이더 비채움 색
    /// UISlider 색, MaximumTrack 색으로 사용
    static var slider_unfilled: UIColor { get { return UIColor(cgColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)) } }
    
}
