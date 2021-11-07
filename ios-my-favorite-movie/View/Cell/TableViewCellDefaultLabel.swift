//
//  MovieContentLabel.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/03.
//

import UIKit

final class TableViewCellDefaultLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultInit()
    }
    
    func defaultInit() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.font = UIFont.preferredFont(forTextStyle: .body)
        self.adjustsFontForContentSizeCategory = true
        self.numberOfLines = 1
    }
}
