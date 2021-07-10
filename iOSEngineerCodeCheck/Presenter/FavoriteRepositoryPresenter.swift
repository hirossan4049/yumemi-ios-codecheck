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
    
    var favoritedCoreDataRepositories: [CoreDataRepository] { get }
}

protocol FavoriteRepositoryPresenterOutput: AnyObject {
    func reload()
}

final class FavoriteRepositoryPresenter: FavoriteRepositoryPresenterInput {
    private var view: FavoriteRepositoryPresenterOutput?
    private var dataManager: FevoriteRepositoryDataManager?
    
    private(set) var favoritedCoreDataRepositories: [CoreDataRepository] = []
    
    init(view: FavoriteRepositoryPresenterOutput,
         dataManager: FevoriteRepositoryDataManager = FevoriteRepositoryDataManager.shared
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

}
