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

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!

    var repository: Repository?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = repository?.name
        languageLabel.text = "Written in \(repository?.language ?? "")"
        starsCountLabel.text = "\(repository?.starCount ?? 0) stars"
        watchersCountLabel.text = "\(repository?.watcherCount ?? 0) watchers"
        forksCountLabel.text = "\(repository?.forkCount ?? 0) forks"
        issuesCountLabel.text = "\(repository?.issueCount ?? 0) open issues"
        
        getImage()

    }

    func getImage() {
        guard let imgURLString = repository?.owner?.avatarImageURL else {
            return
        }
        guard let imgURL = URL(string: imgURLString) else { return }
        URLSession.shared.dataTask(with: imgURL) { (data, res, err) in
            guard let data = data else { return }
            guard let img = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = img
            }
        }.resume()
    }

}
