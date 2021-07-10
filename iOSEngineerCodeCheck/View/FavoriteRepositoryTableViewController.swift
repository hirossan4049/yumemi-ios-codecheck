//
//  FavoriteTableViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by craptone on 2021/07/10.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

class FavoriteRepositoryTableViewController: UITableViewController {
    
    private var presenter: FavoriteRepositoryPresenterInput?
    
    func inject(presenter: FavoriteRepositoryPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let presenter = FavoriteRepositoryPresenter(view: self)
        inject(presenter: presenter)
        self.presenter?.viewDidLoad()
        
        title = "Favorite"
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillApper()
    }
    

    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        self.view.backgroundColor = .backgroundColor
    }


    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.favoritedCoreDataRepositories.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoryTableViewCell
        cell.selectionStyle = .none

        guard let repo = self.presenter?.favoritedCoreDataRepositories[indexPath.row] else { return cell }
        cell.titleLabel.text = repo.name
        cell.usernameLabel.text = repo.username
        cell.descriptionLabel.text = repo.descriptionText
        cell.watchersCountLabel.text = "\(repo.watcherCount)"
        cell.starsCountLabel.text = "\(repo.starCount)"
        cell.forksCountLabel.text = "\(repo.forkCount)"
        cell.userIconImageView.image = nil

        guard let imgURLString = repo.avatarImageURL else {
            return cell
        }
        guard let imgURL = URL(string: imgURLString) else { return cell }
        URLSession.shared.dataTask(with: imgURL) { (data, res, err) in
            guard let data = data else { return }
            guard let img = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                cell.userIconImageView.image = img
            }
        }.resume()
        return cell

    }

    // Cell選択時に呼ばれる
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "RepositoryDetailView") as! RepositoryDetailViewController
        guard let repository = self.presenter?.getRepository(index: indexPath.row) else { return }
        vc.repository = repository
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Cell長押しでContextMenuが開く
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            let deleteFavorite = UIAction(title: "Delete favorite", image: UIImage(systemName: "heart.slash")) { action in
                self.presenter?.deleteFevoriteRepository(indexPath: indexPath)
            }

            return UIMenu(title: "", children: [deleteFavorite])
        })
    }

}

extension FavoriteRepositoryTableViewController: FavoriteRepositoryPresenterOutput {
    func reload() {
        tableView.reloadData()
    }
}
