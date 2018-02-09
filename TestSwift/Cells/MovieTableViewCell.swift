//
//  MovieTableViewCell.swift
//  TestSwift
//
//  Created by ODC on 2/9/18.
//  Copyright © 2018 sonic. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - IBOulets
    
    @IBOutlet weak var borderContentView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    
    // MARK: - Override
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        borderContentView.backgroundColor = selected ? UIColor.lightGray : UIColor.white
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        borderContentView.backgroundColor = highlighted ? UIColor.lightGray : UIColor.white
    }
    
}
