//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchRepositoryViewController: UITableViewController {

    private var presenter: SearchRepositoryPresenterInput?

    func inject(presenter: SearchRepositoryPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let presenter = SearchRepositoryPresenter(view: self)
        inject(presenter: presenter)
        self.presenter?.viewDidLoad()

        title = "Search"

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }


    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        navigationItem.searchController?.searchBar.delegate = self

        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none

        self.view.backgroundColor = .backgroundColor
    }

    func searchRepositories(text: String) {
        guard text.count != 0 else {
            return
        }
        presenter?.searchRepositories(text: text, completion: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if self.presenter?.repositories.count != 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        })
    }

    // MARK: TableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.repositories.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoryTableViewCell
        cell.selectionStyle = .none

        guard let repo = self.presenter?.repositories[indexPath.row] else {
            return cell
        }
        cell.titleLabel.text = repo.name
        cell.usernameLabel.text = repo.owner?.username
        cell.descriptionLabel.text = repo.description
        cell.watchersCountLabel.text = "\(repo.watcherCount ?? 0)"
        cell.starsCountLabel.text = "\(repo.starCount ?? 0)"
        cell.forksCountLabel.text = "\(repo.forkCount ?? 0)"
        cell.userIconImageView.image = nil

        cell.isFavorited = (presenter?.isFavoritedRepositories[indexPath.row] ?? false)

        guard let imgURLString = repo.owner?.avatarImageURL else {
            return cell
        }
        guard let imgURL = URL(string: imgURLString) else {
            return cell
        }
        URLSession.shared.dataTask(with: imgURL) { (data, res, err) in
            guard let data = data else {
                return
            }
            guard let img = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                cell.userIconImageView.image = img
            }
        }.resume()
        return cell

    }

    // Cell選択時に呼ばれる
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "RepositoryDetailView") as! RepositoryDetailViewController
        vc.repository = self.presenter?.repositories[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    // Cell長押しでContextMenuが開く
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            let isFavorite = self.presenter?.isFavoritedRepositories[indexPath.row] ?? false
            if isFavorite {
                let deleteFavorite = UIAction(title: "Delete favorite", image: UIImage(systemName: "heart.slash")) { action in
                    self.presenter?.deleteFavoriteRepository(indexPath: indexPath)
                }

                return UIMenu(title: "", children: [deleteFavorite])
            } else {
                let favorite = UIAction(title: "Favorite", image: UIImage(systemName: "heart")) { action in
                    self.presenter?.favoriteRepository(indexPath: indexPath)
                }

                return UIMenu(title: "", children: [favorite])
            }
        })
    }

}

extension SearchRepositoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.cancelSearch()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text ?? ""
        searchRepositories(text: text)
        navigationItem.searchController?.isActive = false
        navigationItem.searchController?.searchBar.text = text
    }
}

extension SearchRepositoryViewController: SearchRepositoryPresenterOutput {
    func reload() {
        tableView.reloadData()
    }


    func updateCellisFavorite(indexPath: IndexPath, isFavorite: Bool) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RepositoryTableViewCell else {
            return
        }
        cell.isFavorited = isFavorite
    }

}
