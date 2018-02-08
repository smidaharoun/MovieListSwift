//
//  MovieDetailsViewController.swift
//  TestSwift
//
//  Created by ODC on 2/8/18.
//  Copyright © 2018 sonic. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    var data: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        title = data.title
        introLabel.text = data.intro
        textLabel.text = data.text
        coverImageView.setImage(with: URL(string: data.image!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
