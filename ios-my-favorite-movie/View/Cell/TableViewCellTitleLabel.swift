//
//  TableViewCellTitleLabel.swift
//  ios-my-favorite-movie
//
//  Created by 황인우 on 2021/11/05.
//

import UIKit

final class TableViewCellTitleLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultInit()
    }
    
    func defaultInit() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.font = UIFont.preferredFont(forTextStyle: .title3)
        self.adjustsFontForContentSizeCategory = true
        self.numberOfLines = 1
    }
}
