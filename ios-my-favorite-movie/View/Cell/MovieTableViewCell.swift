//
//  MovieTableViewCell.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    weak var delegate: FavoriteMovieSelectionDelegate?
    private var viewModel: MovieTableViewCellModel?
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onTappedFavoriteMovieButton), for: .touchUpInside)
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
    
    @objc private func onTappedFavoriteMovieButton(_ sender: UIButton) {
        guard let indexOfMovie = viewModel?.cellIndex else { return }
        delegate?.handleFavoriteMovieStatus(at: indexOfMovie)
        
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
    
    func bind(_ viewModel: MovieTableViewCellModel) {
        self.viewModel = viewModel
        
        viewModel.cellState.bind { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .update(let metaData):
                    self?.applyViews(using: metaData)
                case .error(let error):
                    self?.moviePosterView.image = UIImage(named: "NoImage")
                    NSLog("No image on cell: \(error.localizedDescription)")
                default:
                    break
                }
            }
        }
        
        viewModel.favoriteButtonState.bind({ [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .checked:
                    self?.favoriteMovieButton.tintColor = .systemYellow
                case .unchecked:
                    self?.favoriteMovieButton.tintColor = .systemGray
                default:
                    break
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
