//
//  MovieTableViewCell.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/02.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
}
