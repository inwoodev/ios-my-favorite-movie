//
//  MovieSearchViewController.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/01.
//

import UIKit

class MovieSearchViewController: UIViewController {
    private let movieTableViewModel = MovieTableViewModel()
    
    private let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.rowHeight = 150
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpSearchController()
        setUpNavigation()
        addSubviews()
        setViewConstraints()
        assignDelegates()
        update()
    }
    
    private func setUpSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    private func setUpNavigation() {
        navigationItem.title = "네이버 영화 검색"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func addSubviews() {
        self.view.addSubview(movieTableView)
    }
    
    private func assignDelegates() {
        movieTableView.dataSource = self
    }
    
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
    
    private func update() {
        movieTableViewModel.movieInformation.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
    }

}

// MARK: - UISearchBarDelegate

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let userInput = searchBar.text else { return }
        
        movieTableViewModel.handleSearchInput(userInput)
    }
}

// MARK: - UITableViewDataSource

extension MovieSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTableViewModel.movieInformation.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell,
              let movie = movieTableViewModel.movieInformation.value?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.bind(MovieTableViewCellModel(movie: movie))
        cell.fire()
        
        return cell
    }
}
