//
//  MovieListTableViewController.swift
//  TestSwift
//
//  Created by ODC on 2/8/18.
//  Copyright © 2018 sonic. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var borderContentView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    
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
    
    var data: [Movie] = []
    var lastExpandedRow: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        initliazeViews()
        loadData()
    }
    
    func initliazeViews() {
        title = "Star Wars"
        navigationController?.navigationBar.isTranslucent = false
        tableView.separatorStyle = .none
    }
    
    func loadData() {
        let url = URL(string: "http://www.mocky.io/v2/5915cf73100000470575966f")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    self.data = try jsonDecoder.decode([Movie].self, from: data).sorted(by: { (lhs, rhs) -> Bool in
                        rhs.year ?? 0 > lhs.year ?? 0
                    })
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        cell.coverImageView.setCornerRadius(radius: 18)
        cell.borderContentView.setCornerRadius(radius: 18)
        cell.borderContentView.setStroke(color: UIColor.gray, width: 1)
        cell.coverImageView.setImage(with: URL(string: item.image!)!)

        return cell
    }
    
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
                angle = -angle
            } else {
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
