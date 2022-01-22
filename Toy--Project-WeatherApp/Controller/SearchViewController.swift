//
//  SearchViewController.swift
//  Toy--Project-WeatherApp
//
//  Created by 정덕호 on 2022/01/16.
//

import UIKit







class SearchViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 280, height: 0))
        searchBar.placeholder = "Search User"
        navigationController?.navigationItem.titleView = searchBar
        
        
        
        
       
        searchBar.delegate = self
        
        
    }
        
    
    
    
    
    
    

    
}




extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("gg")
    }
}

