//
//  MovieTableViewCell.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
    private var viewModel: MovieTableViewCellModel?
    
    private let movieDirectorLabel = TableViewCellDefaultLabel()
    private let movieActorsLabel = TableViewCellDefaultLabel()
    private let movieUserRatingLabel = TableViewCellDefaultLabel()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        return label
    }()
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addSubviews() {
        self.contentView.addSubview(moviePosterView)
        self.contentView.addSubview(movieInformationStackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            moviePosterView.widthAnchor.constraint(equalToConstant: 90),
            moviePosterView.heightAnchor.constraint(equalToConstant: 120),
            moviePosterView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            moviePosterView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            movieInformationStackView.topAnchor.constraint(equalTo: moviePosterView.topAnchor),
            movieInformationStackView.leadingAnchor.constraint(equalTo: moviePosterView.trailingAnchor, constant: 5),
            movieInformationStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            movieInformationStackView.bottomAnchor.constraint(equalTo: moviePosterView.bottomAnchor)
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
                    guard let dataAsset = NSDataAsset.init(name: "NoImage") else { return }
                    self?.moviePosterView.image = UIImage(data: dataAsset.data)
                    NSLog("No image on cell: \(error.localizedDescription)")
                default:
                    break
                }
            }
        }
    }
    
    func fire() {
        viewModel?.fire()
    }
    
    private func applyViews(using metaData: MovieTableViewCellModel.MetaData) {
        self.movieTitleLabel.text = metaData.title
        self.moviePosterView.image = metaData.image
        self.movieDirectorLabel.text = "감독: \(metaData.director.replacingOccurrences(of: "|", with: ""))"
        self.movieActorsLabel.text = "출연: \(metaData.actors.replacingOccurrences(of: "|", with: ", "))"
        self.movieUserRatingLabel.text = "평점: \(metaData.userRating)"
    }
}
