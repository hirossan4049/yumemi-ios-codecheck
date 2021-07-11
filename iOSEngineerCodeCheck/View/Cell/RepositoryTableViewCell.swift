//
//  RepositoryTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by craptone on 2021/07/08.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userIconImageView: UIImageView!

    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!

    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteImageView: UIImageView!

    public var isFavorited = false {
        didSet {
            favoriteView.isHidden = !isFavorited
            favoriteImageView.isHidden = !isFavorited
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }

    func setupView() {
        backgroundColor = .backgroundColor

        backView.backgroundColor = .secondaryBackgroundColor
        backView.layer.cornerRadius = 14
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.04
        backView.layer.shadowRadius = 4
        backView.clipsToBounds = true

        favoriteView.transform = CGAffineTransform(rotationAngle: 45 * CGFloat.pi / 180);

        usernameLabel.textColor = .tertiaryLabelColor

        userIconImageView.clipsToBounds = true
        userIconImageView.layer.cornerRadius = userIconImageView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
