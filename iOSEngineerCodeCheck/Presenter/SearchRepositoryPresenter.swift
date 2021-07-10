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
    func viewWillApper()
    func favoriteRepository(indexPath: IndexPath)
    func deleteFevoriteRepository(indexPath: IndexPath)
    func searchRepositories(text: String, completion: @escaping(() -> ()))
    func cancelSearch()
    
    var repositories: [Repository] {get}
    var isFavoritedRepositories: [Bool] {get}
}


protocol SearchRepositoryPresenterOutput: AnyObject {
    func reload()
}

final class SearchRepositoryPresenter: SearchRepositoryPresenterInput {
    
    private weak var view: SearchRepositoryPresenterOutput?
    private var api: GithubAPIInput?
    private var dataManager: FevoriteRepositoryDataManager?
    
    private(set) var repositories: [Repository] = []
    private(set) var favoritedCoreDataRepositories: [CoreDataRepository] = []
    private(set) var isFavoritedRepositories: [Bool] = []
        
    init(view: SearchRepositoryPresenterOutput,
         api: GithubAPIInput = GithubAPI.shared,
         dataManager: FevoriteRepositoryDataManager = FevoriteRepositoryDataManager.shared
    ) {
        self.view = view
        self.api = api
        self.dataManager = dataManager
    }
    
    func viewDidLoad() {

    }
    
    func viewWillApper() {
        dataManager?.fetchItems(completion: { (repo) in
            self.favoritedCoreDataRepositories = repo ?? []
            self.searchFavoritedRepositories()
            self.view?.reload()
        })
    }
    
    func favoriteRepository(indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        dataManager?.addItem(repository: repository)
        dataManager?.fetchItems(completion: { (repo) in
            self.favoritedCoreDataRepositories = repo ?? []
            self.searchFavoritedRepositories()
            self.view?.reload()
        })
    }
    
    func deleteFevoriteRepository(indexPath: IndexPath) {
        let id = repositories[indexPath.row].id
        var coredataRepo: CoreDataRepository?
        for repo in self.favoritedCoreDataRepositories {
            if Int(repo.id) == id {
                coredataRepo = repo
                break
            }
        }
        if coredataRepo == nil { return }
        dataManager?.delete(coredataRepo!)
        dataManager?.fetchItems(completion: { (repo) in
            self.favoritedCoreDataRepositories = repo ?? []
            self.searchFavoritedRepositories()
            self.view?.reload()
        })
    }
    
    
    func searchRepositories(text: String, completion: @escaping(() -> ())) {
        api?.fetchSearchRepositories(text: text, completion: { repositories in
            self.repositories = repositories
            self.searchFavoritedRepositories()
            completion()
        })
    }
    
    func cancelSearch() {
        api?.cancel()
    }
    
    
    private func isFavorited(repository: Repository) -> Bool {
        for repo in favoritedCoreDataRepositories {
            guard let id = repository.id else { continue }
            if id == repo.id {
                return true
            }
        }
        return false
    }
    
    // Favorite済みのリポジトリーがあるかをみる。repositoriesから探し、結果がisFavoritedRepositoriesに入る。
    private func searchFavoritedRepositories() {
        isFavoritedRepositories = []
        let ids = favoritedCoreDataRepositories.map({ $0.id })
        for repo in repositories {
            guard let id = repo.id else { continue }
            isFavoritedRepositories.append( ids.contains(Int32(id)) )
        }
    }
    
}
