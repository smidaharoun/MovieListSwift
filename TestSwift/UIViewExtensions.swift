//
//  UIViewExtensions.swift
//  TestSwift
//
//  Created by ODC on 2/8/18.
//  Copyright © 2018 sonic. All rights reserved.
//

import UIKit

private var activityIndicator: UIActivityIndicatorView!

public extension UIView {
    public func startLoading() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.tintColor = UIColor.black
        }
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        center(subView: activityIndicator)
    }
    
    public func setErrorState(title: String = "A problem occured, please try again", selector: Selector) {
        if activityIndicator != nil {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    func center(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subView.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
}


extension UIView {
    func setCornerRadius(radius: Int = 30) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    func setStroke(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
