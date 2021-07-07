//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var langLabel: UILabel!

    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!

    var vc1: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let repo = vc1.repositories[vc1.selectedIndex]

        langLabel.text = "Written in \(repo["language"] as? String ?? "")"
        starsLabel.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()

    }

    func getImage() {
        let repo = vc1.repositories[vc1.selectedIndex]

        titleLabel.text = repo["full_name"] as? String

        guard let owner = repo["owner"] as? [String: Any] else {
            return
        }
        guard let imgURL = owner["avatar_url"] as? String else {
            return
        }
        URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
            let img = UIImage(data: data!)!
            DispatchQueue.main.async {
                self.avatarImageView.image = img
            }
        }.resume()
    }

}
