//
//  SearchViewController.swift
//  ListeningDictionary
//
//  Created by Wi on 03/08/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Private Field
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private func
    
    private func configure(){
        self.title = "Search"
        self.tabBarItem.title = "Search"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        self.searchController.obscuresBackgroundDuringPresentation = false // 검색하는 동안 기본내용이 가려져 있을지
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
    }

}

// MARK: - UISearchResultsUpdating Delegate

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // searchBar 에서 글자를 눌렀을 때
        
        
    }
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // 스코프를 눌렀을때
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // cancel 버튼 눌렀을때
        
        
    }
}
