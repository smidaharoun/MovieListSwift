//
//  MovieDetailsViewController.swift
//  TestSwift
//
//  Created by Haroun SMIDA on 2/8/18.

//  Copyright © 2018 sonic. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    // MARK: - IBOulets
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: Global variables
    
    var data: Movie!
    
    // MARK: - View controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: Handling Data
    
    func loadData() {
        title = data.title
        introLabel.text = data.intro
        textLabel.text = data.text
        if let image = data.image, let url = URL(string: image) {
            coverImageView.kf.setImage(with: url,
                                       placeholder: nil,
                                       options: nil,
                                       progressBlock: nil,
                                       completionHandler: nil)
        }
    }
}
