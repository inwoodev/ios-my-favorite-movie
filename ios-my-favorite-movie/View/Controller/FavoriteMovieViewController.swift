//
//  FavoriteMovieViewController.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/04.
//

import UIKit
import SafariServices

final class FavoriteMovieViewController: UIViewController {
    private let favoriteMovieTableViewModel: FavoriteMovieTableViewModel
    
    private let movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteMovieTableViewCell.self, forCellReuseIdentifier: FavoriteMovieTableViewCell.identifier)
        tableView.rowHeight = 150
        return tableView
    }()
    
    init(favoriteMovieTableViewModel: FavoriteMovieTableViewModel) {
        self.favoriteMovieTableViewModel = favoriteMovieTableViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = "즐겨찾는 영화"
        addSubviews()
        assignDelegates()
        setViewConstraints()
        updateFavoriteViews()
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
    
    private func updateFavoriteViews() {
        favoriteMovieTableViewModel.favoriteList.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
    }
}

extension FavoriteMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteMovieTableViewModel.favoriteList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieTableViewCell.identifier, for: indexPath) as? FavoriteMovieTableViewCell else {
            return UITableViewCell()
        }
        guard let favoriteMovieData = favoriteMovieTableViewModel.favoriteList.value?[indexPath.row] else {
            return UITableViewCell()
            
        }
        
        cell.delegate = self
        let cellModel = FavoriteMovieTableViewCellModel(metaData: favoriteMovieData, movieImageService: MovieImageService(), cellIndex: indexPath.row)
        
        cell.bind(cellModel)
        cell.fire()
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension FavoriteMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieLink = favoriteMovieTableViewModel.favoriteList.value?[indexPath.row].link,
              let movieURL = try? movieLink.convertToURL() else { return }
        let safariViewController = SFSafariViewController(url: movieURL)
        
        present(safariViewController, animated: true, completion: nil)
    }
}

// MARK: - MovieRemoveDelegate

extension FavoriteMovieViewController: MovieRemoveDelegate {
    func removeUncheckedMovie() {
        favoriteMovieTableViewModel.removeUnfavoriteMovie()
    }
}
