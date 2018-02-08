//
//  UILabelExtensions.swift
//  TestSwift
//
//  Created by ODC on 2/8/18.
//  Copyright © 2018 sonic. All rights reserved.
//

import UIKit

extension UILabel {
    func textHeight() -> CGFloat{
        let fontAttributes = [NSAttributedStringKey.font: font] as [NSAttributedStringKey : Any]
        let size = (text! as NSString).size(withAttributes: fontAttributes)
        return size.height
    }
}
