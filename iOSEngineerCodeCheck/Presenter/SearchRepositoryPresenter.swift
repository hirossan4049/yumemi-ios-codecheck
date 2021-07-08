//
//  SearchRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by craptone on 2021/07/08.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation


protocol SearchRepositoryPresenterInput {
    func viewDidLoad()
    func searchRepositories(text: String, completion: @escaping(() -> ()))
    func cancelSearch()
    var repositories: [Repository] {get}
}


protocol SearchRepositoryPresenterOutput: AnyObject {
    
}

final class SearchRepositoryPresenter: SearchRepositoryPresenterInput {
    
    private weak var view: SearchRepositoryPresenterOutput?
    private var api: GithubAPIInput?
    
    private(set) var repositories: [Repository] = []
    
    init(view: SearchRepositoryPresenterOutput, api: GithubAPIInput = GithubAPI.shared) {
        self.view = view
        self.api = api
    }
    
    func viewDidLoad() {
        
    }
    
    func searchRepositories(text: String, completion: @escaping(() -> ())) {
        api?.fetchSearchRepositories(text: text, completion: { repositories in
            self.repositories = repositories
            completion()
        })
    }
    
    func cancelSearch() {
        api?.cancel()
    }
    
}
