//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//
import UIKit

class MovieCell: UICollectionViewCell {

    static let reuseIdentifier = "movie-cell-reuse-identifier"
    let imageView = UIImageView()
    let budgetLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension MovieCell {
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        contentView.addSubview(budgetLabel)

        budgetLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        budgetLabel.adjustsFontForContentSizeCategory = true
        budgetLabel.textAlignment = .center
        budgetLabel.textColor = UIColor(red: 0.73, green: 0.88, blue: 0.98, alpha: 1)

        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = UIColor.placeholderText

        let spacing = CGFloat(10)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),

            budgetLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            budgetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            budgetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            budgetLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
}
