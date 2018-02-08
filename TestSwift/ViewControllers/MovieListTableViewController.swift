//
//  MovieListTableViewController.swift
//  TestSwift
//
//  Created by ODC on 2/8/18.
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
    
    override var isSelected: Bool {
        didSet {
            self.borderContentView.backgroundColor = isSelected ? UIColor.lightGray : UIColor.white
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            self.borderContentView.backgroundColor =  isHighlighted ? UIColor.lightGray : UIColor.white
        }
    }
}

class MovieListTableViewController: UITableViewController {
    
    // MARK: - Global Variables
    
    var data: [Movie] = []
    var lastExpandedRow: Int = -1

    // MARK: - View controller methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initliazeViews()
        loadData()
    }
    
    // MARK: - Initialization

    func initliazeViews() {
        title = "Star Wars"
        navigationController?.navigationBar.isTranslucent = false
        tableView.separatorStyle = .none
    }
    
    // MARK: Handling Data Results

    func loadData() {
        view.startLoading()
        Api.getMovies { (data, error) in
            self.view.stopLoading()
            if data != nil {
                self.data = data!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if lastExpandedRow == indexPath.row {
            return 150 + (data[indexPath.row].intro?.height(withConstrainedWidth: view.frame.width - 118, font: UIFont.systemFont(ofSize: 13)))! - 51
        }
        return 150
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let item = data[indexPath.row]
        
        cell.selectionStyle = .none
        cell.titleLabel.text = item.title
        cell.yearLabel.text = "\(item.year!)"
        cell.descriptionLabel.text = item.intro
        cell.descriptionLabel.contentMode = .top
        cell.seeMoreButton.tag = indexPath.row
        cell.seeMoreButton.addTarget(self, action: #selector(collapseAction(_:)), for: .touchUpInside)
        if lastExpandedRow != indexPath.row {
            cell.seeMoreButton.transform = CGAffineTransform(rotationAngle: 0)
        } else {
            cell.seeMoreButton.transform = CGAffineTransform(rotationAngle: .pi * 0.5)
        }
        cell.coverImageView.setCornerRadius(radius: 18)
        cell.borderContentView.setCornerRadius(radius: 18)
        cell.borderContentView.setStroke(color: UIColor.gray, width: 1)
        cell.coverImageView.setImage(with: URL(string: item.image!)!)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MovieDetailsViewController.self)) as! MovieDetailsViewController
        viewController.data = data[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - IBActions
    @objc func collapseAction(_ sender: Any) {
        if let button = sender as? UIButton, let cell = tableView.cellForRow(at: IndexPath(row: button.tag, section: 0)) as? MovieTableViewCell {
            var angle: CGFloat = .pi * 0.5
            if lastExpandedRow == button.tag {
                lastExpandedRow = -1
                angle = 0
            } else {
                if let previousCell = tableView.cellForRow(at: IndexPath(row: lastExpandedRow, section: 0)) as? MovieTableViewCell {
                    UIView.animate(withDuration: 0.2, animations: {
                        previousCell.seeMoreButton.transform = CGAffineTransform(rotationAngle: 0)
                    })
                }
                lastExpandedRow = button.tag
            }
            UIView.animate(withDuration: 0.2, animations: {
                cell.seeMoreButton.transform = CGAffineTransform(rotationAngle: angle)
            })
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}
