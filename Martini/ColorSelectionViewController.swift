//
//  ColorSelectionViewController.swift
//  Martini
//
//  Created by RONICK on 2021/09/18.
//

import UIKit

class ColorSelectionViewController: UIViewController {

    @IBOutlet var colorSelectionCollectionView: UICollectionView!
    
    @IBOutlet var btnComplete: UIButton!
    
    let identifier = "colorSelectionCollectionViewCell"
    let spacingRow = 5
    let spacingColumn = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        colorSelectionCollectionView.delegate = self
        colorSelectionCollectionView.dataSource = self
        
        colorSelectionCollectionView.register(ColorSelectionCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        btnComplete.layer.cornerRadius = 6
        
    }
    
    @IBAction func btnDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension ColorSelectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(spacingRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(spacingColumn)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = colorSelectionCollectionView.bounds.width / 7 - CGFloat(spacingColumn)
        let height = colorSelectionCollectionView.bounds.height / 7 - CGFloat(spacingRow)
        
        return CGSize(width: width, height: height)
    }
}

extension ColorSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cocktail.Color.allCases.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorSelectionCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ColorSelectionCollectionViewCell
        
        let color = Cocktail.Color.allCases[indexPath.row]
        
        let colorInfo = getColorInfo(color: color)
        
        cell.configure(color: colorInfo.color, index: indexPath.row)
        
        return cell
    }
    
    func getColorInfo(color: Cocktail.Color) -> ColorInfo {
        switch color {
        case .blue  : return ColorInfo(title: "파랑색", color: UIColor.blue)
        case .green : return ColorInfo(title: "녹색", color: UIColor.green)
        case .orange: return ColorInfo(title: "주황색", color: UIColor.orange)
        case .pink  : return ColorInfo(title: "핑크색", color: UIColor.systemPink)
        case .red   : return ColorInfo(title: "빨강색", color: UIColor.red)
        case .teal  : return ColorInfo(title: "청록색", color: UIColor.systemTeal)
        case .yellow: return ColorInfo(title: "노랑색", color: UIColor.yellow)
        case .purple: return ColorInfo(title: "보라색", color: UIColor.systemPurple)
        default     : return ColorInfo(title: "무색", color: UIColor())
        }
    }
    
}


struct ColorInfo {
    let title: String
    let color: UIColor
}
