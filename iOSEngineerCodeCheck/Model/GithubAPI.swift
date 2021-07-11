//
//  GithubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by craptone on 2021/07/08.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GithubAPIInput {
    func fetchSearchRepositories(text: String, completion: @escaping ([Repository]) -> ())
    func cancel()
}

class GithubAPI: GithubAPIInput {
    static let shared = GithubAPI()

    private var task: URLSessionTask?

    func fetchSearchRepositories(text: String, completion: @escaping ([Repository]) -> ()) {
        let urlText = "https://api.github.com/search/repositories?q=\(text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
        guard let url = URL(string: urlText) else {
            return
        }
        task = URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {
                return
            }
            guard let repos = try? JSONDecoder().decode(Repositories.self, from: data) else {
                return
            }
            completion(repos.items)
        }
        // これ呼ばなきゃ通信が開始されません
        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }
}
