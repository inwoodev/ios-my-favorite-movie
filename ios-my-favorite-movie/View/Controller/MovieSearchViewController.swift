//
//  MovieSearchViewController.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/01.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        setUpNavigation()
        addSubviews()
        setViewConstraints()
    }
    
    private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    private func setUpNavigation() {
        navigationItem.searchController = searchController
    }
    
    private func addSubviews() {
        self.view.addSubview(searchController.searchBar)
        self.view.addSubview(movieTableView)
    }
    
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            searchController.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchController.searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            searchController.searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            searchController.searchBar.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            movieTableView.topAnchor.constraint(equalTo: searchController.searchBar.bottomAnchor, constant: 5),
            movieTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
        
    }

}
extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

extension MovieSearchViewController: UISearchBarDelegate {
    
}
