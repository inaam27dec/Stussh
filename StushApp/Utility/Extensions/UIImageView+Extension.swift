//
//  UIImageView+Extension.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//


import UIKit
import SDWebImage

extension UIImageView {
    public func sd_setImageWithURLWithFade(url: URL!, placeholderImage placeholder: UIImage!)
    {
        self.sd_setImage(with: url, placeholderImage: placeholder,options: SDWebImageOptions(rawValue: 0)) { (image, error, cacheType, url) -> Void in
            
            if let downLoadedImage = image
            {
                if cacheType == .none
                {
                    self.alpha = 0
                    UIView.transition(with: self, duration: 0.4, options: UIView.AnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                        self.image = downLoadedImage
                        self.alpha = 1
                    }, completion: nil)
                }
            }
            else
            {
                self.image = placeholder
            }
        }
    }
    
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
            
        }).resume()
    }
}

