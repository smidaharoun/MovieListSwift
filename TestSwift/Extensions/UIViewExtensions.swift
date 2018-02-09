//
//  UIViewExtensions.swift
//  TestSwift
//
//  Created by Haroun SMIDA on 2/8/18.

//  Copyright © 2018 sonic. All rights reserved.
//

import UIKit

private var activityIndicator: UIActivityIndicatorView!

public extension UIView {
    
    /// Add an UIActivityIndicatorView to the view and start loading,
    /// this method is called when there is a network call.
    public func startLoading() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicator.color = UIColor.black
        }
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        center(subView: activityIndicator)
    }
    
    /// Remove the UIActivityIndicatorView added before.
    public func stopLoading() {
        if activityIndicator != nil {
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    /// this method is used to center a given view in the superView with NSLayoutConstraint
    func center(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subView.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
    
}


extension UIView {
    
    /// this method apply a corner radius to the view
    func setCornerRadius(radius: Int = 30) {
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
    }
    
    // this method set stroke the view with the given color and width
    func setStroke(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
}
