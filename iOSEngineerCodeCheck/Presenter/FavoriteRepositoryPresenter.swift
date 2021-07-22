//
//  FavoriteRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by craptone on 2021/07/10.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol FavoriteRepositoryPresenterInput {
    func viewDidLoad()
    func viewWillApper()
    func deleteFavoriteRepository(indexPath: IndexPath)
    func getRepository(index: Int) -> Repository?

    var favoritedCoreDataRepositories: [CoreDataRepository] { get }
}

protocol FavoriteRepositoryPresenterOutput: AnyObject {
    func reload()
    func deleteCell(indexPath: IndexPath)
}

final class FavoriteRepositoryPresenter: FavoriteRepositoryPresenterInput {
    private var view: FavoriteRepositoryPresenterOutput?
    private var dataManager: FavoriteRepositoryDataManager?

    private(set) var favoritedCoreDataRepositories: [CoreDataRepository] = []

    init(view: FavoriteRepositoryPresenterOutput,
         dataManager: FavoriteRepositoryDataManager = FavoriteRepositoryDataManager.shared
    ) {
        self.view = view
        self.dataManager = dataManager
    }

    func viewDidLoad() {

    }

    func viewWillApper() {
        dataManager?.fetchItems(completion: { (repo) in
            self.favoritedCoreDataRepositories = repo?.reversed() ?? []
            self.view?.reload()
        })
    }

    func deleteFavoriteRepository(indexPath: IndexPath) {
        dataManager?.delete(favoritedCoreDataRepositories[indexPath.row])
        dataManager?.saveContext()
        dataManager?.fetchItems(completion: { (repo) in
            self.favoritedCoreDataRepositories = repo ?? []
            self.view?.deleteCell(indexPath: indexPath)
        })
    }

    func getRepository(index: Int) -> Repository? {
        return dataManager?.coreDataRepository2Repository(coreDataRepository: favoritedCoreDataRepositories[index])
    }

}
