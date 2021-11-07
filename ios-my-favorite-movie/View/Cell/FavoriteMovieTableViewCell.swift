//
//  FavoriteMovieTableViewCell.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/05.
//

import UIKit

final class FavoriteMovieTableViewCell: UITableViewCell {
    static let identifier = "FavoriteMovieTableViewCell"
    weak var delegate: MovieRemoveDelegate?
    private var viewModel: FavoriteMovieTableViewCellModel?
    private let movieDirectorLabel = TableViewCellDefaultLabel()
    private let movieActorsLabel = TableViewCellDefaultLabel()
    private let movieUserRatingLabel = TableViewCellDefaultLabel()
    private let movieTitleLabel = TableViewCellTitleLabel()
    
    private lazy var movieInformationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieTitleLabel, movieDirectorLabel, movieActorsLabel, movieUserRatingLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let moviePosterView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        return imageView
    }()
    
    private lazy var favoriteMovieButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "star_filled"), for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onTappedUnfavoriteMovieButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func onTappedUnfavoriteMovieButton(_ sender: UIButton) {
        guard let movieTitle = movieTitleLabel.text else { return }
        self.delegate?.removeUncheckedMovie(using: movieTitle)
    }
    
    private func addSubviews() {
        self.contentView.addSubview(moviePosterView)
        self.contentView.addSubview(movieInformationStackView)
        self.contentView.addSubview(favoriteMovieButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            moviePosterView.widthAnchor.constraint(equalToConstant: 90),
            moviePosterView.heightAnchor.constraint(equalToConstant: 120),
            moviePosterView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            moviePosterView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            movieInformationStackView.topAnchor.constraint(equalTo: moviePosterView.topAnchor),
            movieInformationStackView.leadingAnchor.constraint(equalTo: moviePosterView.trailingAnchor, constant: 5),
            movieInformationStackView.bottomAnchor.constraint(equalTo: moviePosterView.bottomAnchor),
            
            favoriteMovieButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteMovieButton.widthAnchor.constraint(equalTo: favoriteMovieButton.heightAnchor),
            favoriteMovieButton.topAnchor.constraint(equalTo: movieInformationStackView.topAnchor),
            favoriteMovieButton.leadingAnchor.constraint(equalTo: movieInformationStackView.trailingAnchor, constant: 5),
            favoriteMovieButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5)
        ])
    }
    
    func bind(_ viewModel: FavoriteMovieTableViewCellModel) {
        self.viewModel = viewModel
        viewModel.favoriteButtonState.bind({ [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .checked(let metaData):
                    self?.favoriteMovieButton.tintColor = .systemYellow
                    self?.applyViews(using: metaData)
                case .unchecked:
                    self?.favoriteMovieButton.tintColor = .systemGray

                default:
                    self?.favoriteMovieButton.tintColor = .systemGray
                }
            }
        })
    }
    
    func fire() {
        viewModel?.fire()
    }
    
    private func applyViews(using metaData: ContentMetaData) {
        self.movieTitleLabel.text = metaData.title
        self.moviePosterView.image = metaData.image
        self.movieDirectorLabel.text = "감독: \(metaData.director.replacingOccurrences(of: "|", with: ""))"
        self.movieActorsLabel.text = "출연: \(metaData.actors.replacingOccurrences(of: "|", with: ", "))"
        self.movieUserRatingLabel.text = "평점: \(metaData.userRating)"
    }
}
