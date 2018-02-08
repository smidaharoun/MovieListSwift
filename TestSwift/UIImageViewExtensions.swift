//
//  UIImageViewExtensions.swift
//  TestSwift
//
//  Created by ODC on 2/8/18.
//  Copyright © 2018 sonic. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(with url:URL) {
        URLSession.shared.dataTask( with: url, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  .scaleAspectFill
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
