//
//  SearchViewController.swift
//  Toy--Project-WeatherApp
//
//  Created by 정덕호 on 2022/01/16.
//

import UIKit





class resultViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .blue
    }
}

class SearchViewController: UIViewController, UISearchResultsUpdating {

    let searchController = UISearchController(searchResultsController: resultViewController())
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "날씨"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        
        
        
        
        
        
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        
        let viewController = searchController.searchResultsController as? resultViewController
        viewController?.view.backgroundColor = .brown
        print(text)
        
    }
    
    
    
    
    
    
    

    
}
