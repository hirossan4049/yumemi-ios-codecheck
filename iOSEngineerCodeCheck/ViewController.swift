//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    private(set) var repositories: [Repository] = []

    var task: URLSessionTask?
    var searchText: String = ""
    private(set) var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text ?? ""
        guard searchText.count != 0 else {
            return
        }

        let url = "https://api.github.com/search/repositories?q=\(searchText)"
        task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            guard let data = data else { return }
            guard let hage = try? JSONDecoder().decode(Repositories.self, from: data) else { return }
            self.repositories = hage.items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        // これ呼ばなきゃ通信が開始されません
        task?.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "Detail" {
            let dtl = segue.destination as! ViewController2
            guard let index = selectedIndex else { return }
            dtl.repository = repositories[index]
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        let repo = repositories[indexPath.row]
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
