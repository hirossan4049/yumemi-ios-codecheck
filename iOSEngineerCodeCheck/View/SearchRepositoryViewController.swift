//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UITableViewController {

    private(set) var selectedIndex: Int?
    
    private var presenter: SearchRepositoryPresenterInput?
    
    func inject(presenter: SearchRepositoryPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let presenter = SearchRepositoryPresenter(view: self)
        inject(presenter: presenter)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        navigationItem.searchController?.searchBar.delegate = self

        title = "Search"
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            guard let dtl = segue.destination as? RepositoryDetailViewController else { return }
            guard let index = selectedIndex else { return }
            dtl.repository = self.presenter?.repositories[index]
        }
    }

    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.presenter?.repositories.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let repo = self.presenter?.repositories[indexPath.row] else { return cell }
        cell.textLabel?.text =  repo.name
        cell.detailTextLabel?.text = repo.language
        cell.tag = indexPath.row
        return cell

    }

    // Cell選択時に呼ばれる
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
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
    
}
