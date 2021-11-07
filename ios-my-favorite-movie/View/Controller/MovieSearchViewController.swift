//
//  MovieSearchViewController.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/01.
//

import UIKit
import SafariServices

final class MovieSearchViewController: UIViewController {
    private let movieTableViewModel = MovieTableViewModel()
    private let favoriteTableViewModel = FavoriteMovieTableViewModel()
    private let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.rowHeight = 150
        return tableView
    }()
    
    private lazy var favoriteMovieButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(pushToFavoriteMoviePage))
    
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
        navigationItem.rightBarButtonItem = favoriteMovieButton
    }
    
    private func addSubviews() {
        self.view.addSubview(movieTableView)
    }
    
    private func assignDelegates() {
        movieTableView.dataSource = self
        movieTableView.delegate = self
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
    
    @objc private func pushToFavoriteMoviePage() {
        let favoriteMovieViewController = FavoriteMovieViewController(favoriteMovieTableViewModel: favoriteTableViewModel)
        navigationController?.pushViewController(favoriteMovieViewController, animated: false)
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
        cell.delegate = self
        
        var favoriteButtonState = FavoriteButtonState.unchecked
        if movie.favoriteStatus == .checked {
            favoriteButtonState = .checked
            selectFavoriteMovie(at: indexPath.row)
        } else if movie.favoriteStatus == .unchecked {
            favoriteButtonState = .unchecked
            deselectFavoriteMovie()
        }
        
        cell.bind(MovieTableViewCellModel(metaData: movie, cellIndex: indexPath.row, favoriteButtonState: Observable(favoriteButtonState)))
        cell.fire()
        
        return cell
    }
    
    private func deselectFavoriteMovie() {
        favoriteTableViewModel.removeUnfavoriteMovie()
    }
    
    private func selectFavoriteMovie(at index: Int) {
        guard let selectedMovie = movieTableViewModel.movieInformation.value?[index] else { return }
        
        favoriteTableViewModel.addFavoriteMovie(selectedMovie: selectedMovie)
        
    }
}

// MARK: - UITableViewDelegate

extension MovieSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieLink = movieTableViewModel.movieInformation.value?[indexPath.row].link,
              let movieURL = try? movieLink.convertToURL() else { return }
        let safariViewController = SFSafariViewController(url: movieURL)
        
        present(safariViewController, animated: true, completion: nil)
    }
}

// MARK: - FavoriteMovieSelectable

extension MovieSearchViewController: FavoriteMovieSelectionDelegate {
    func handleFavoriteMovieStatus(at index: Int) {
        movieTableViewModel.handleFavoriteMovieStatus(of: index)
    }
}
