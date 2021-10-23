//
//  WebImageView.swift
//  Martini
//
//  Created by Jingyu Lim on 2021/08/15.
//

import UIKit

class WebImageView: UIImageView {
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        indicator.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let imageCache = NSCache<NSString, UIImage>()
    
    let fileManager = FileManager()
    
    var imageUrl: String? {
        didSet{
            guard let imageUrl = imageUrl else {
                self.image = nil
                self.indicator.stopAnimating()
                return
            }
            
            getImage(urlString: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.image = image
                    self?.indicator.stopAnimating()
                }
            }
        }
    }
    
    
    
    func getImage(urlString: String, completeHandler: @escaping (_ image: UIImage?)->()){
        
        guard let url = URL(string: urlString) else { return }
        
        self.addSubview(indicator)
        
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            return
        }
        
        var filePath = URL(fileURLWithPath: path)
        filePath.appendPathComponent(url.lastPathComponent)
        
        if let cacheImage = imageCache.object(forKey: url.lastPathComponent as NSString){
            completeHandler(cacheImage)
            return
        }
        
        if self.fileManager.fileExists(atPath: filePath.path){
            if let imageData = try? Data(contentsOf: filePath){
                let image = UIImage(data: imageData)!
                completeHandler(image)
            }
            return
        }
        
        indicator.startAnimating()
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "")
                completeHandler(nil)
            }
            
            guard let data = data else {
                print("404 NotFound")
                completeHandler(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Data is not Image")
                completeHandler(nil)
                return
            }
            
            self?.imageCache.setObject(image, forKey: url.lastPathComponent as NSString)
            
            if !(self?.fileManager.fileExists(atPath: filePath.path) ?? false){
                self?.fileManager.createFile(atPath: filePath.path, contents: image.jpegData(compressionQuality: 0.4), attributes: nil)
            }
            
            completeHandler(image)
        }.resume()
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
