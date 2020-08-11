//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 29..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: Movie?

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        descriptionTextView.text = movie.overview
        
        if let posterPath = movie.posterPath,
            let posterPathURL = URL(string: "http://image.tmdb.org/t/p/w500\(posterPath)") {
            
            posterImageView.kf.setImage(with: posterPathURL)
        }

        if let budget = movie.budget {
            budgetLabel.text = String.currency(from: budget)
        }
    }
}
