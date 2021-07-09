//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var issuesCountLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    var repository: Repository?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationItem.largeTitleDisplayMode = .never
        title = "\(repository?.owner?.username ?? "")/\(repository?.name ?? "")"
        
        titleLabel.text = "\(repository?.name ?? "")"
        usernameLabel.text = "\(repository?.owner?.username ?? "")"
        languageLabel.text = "Written in \(repository?.language ?? "")"
        starsCountLabel.text = "\(repository?.starCount ?? 0) stars"
        watchersCountLabel.text = "\(repository?.watcherCount ?? 0) watchers"
        forksCountLabel.text = "\(repository?.forkCount ?? 0) forks"
        issuesCountLabel.text = "\(repository?.issueCount ?? 0) open issues"
        descriptionTextView.text = "\(repository?.description ?? "")"
        
        usernameLabel.textColor = .tertiaryLabelColor
        
        view.backgroundColor = .backgroundColor
        
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                
        getImage()
    }

    private func getImage() {
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
