//
//  RepositoryDetailCounterView.swift
//  iOSEngineerCodeCheck
//
//  Created by craptone on 2021/07/09.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

@IBDesignable
class RepositoryDetailCounterView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!

    @IBInspectable var title: String = "" {
        didSet {
            titleLabel?.text = title
        }
    }

    @IBInspectable var iconImage: UIImage = UIImage() {
        didSet {
            iconImageView?.image = iconImage
        }
    }

    @IBInspectable var counter: String = "" {
        didSet {
            counterLabel?.text = counter
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
        setUpView()
    }

    func setUpView() {
        self.backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.04
        layer.shadowRadius = 4
    }


    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            view.backgroundColor = .clear
            self.addSubview(view)
        }
    }

}
