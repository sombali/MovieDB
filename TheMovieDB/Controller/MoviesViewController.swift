//
//  MoviesViewController.swift
//  TheMovieDB
//
//  Created by Somogyi Balázs on 2020. 02. 28..
//  Copyright © 2020. Somogyi Balázs. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var movies: [Movie] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    let moviesDataSource = MovieDataSource.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesDataSource.delegate = self
        
        searchBar.searchTextField.textColor = UIColor(red:0.73, green: 0.88, blue: 0.98, alpha:1.0)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for a movie", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red:0.01, green:0.15, blue:0.17, alpha:1.0)])
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        collectionView.collectionViewLayout = createLayout()
        collectionView.delegate = self
        
        searchBar.delegate = self
        
        configureDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let detailVC = segue.destination as? MovieDetailViewController,
                let cell = sender as? UICollectionViewCell,
                let indexPath = self.collectionView!.indexPath(for: cell),
                let movie  = self.dataSource.itemIdentifier(for: indexPath) {
                
                detailVC.movie = movie
            }
        }
    }
}

extension MoviesViewController {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension MoviesViewController {    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else {
                fatalError("Cannot create CollectionViewCell")
            }
            
            if let posterPath = movie.posterPath, let posterPathURL = URL(string: "http://image.tmdb.org/t/p/w500\(posterPath)") {
                cell.imageView.kf.setImage(with: posterPathURL)
            }
            
            if let budget = movie.budget {
                cell.budgetLabel.text = String.currency(from: budget)
            }
            
            return cell
        })
        
        configureSnapshot()
    }
    
    func configureSnapshot() {
        var currentSnapshot = NSDiffableDataSourceSnapshot<Section, Movie>()

        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(movies)

        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: "detailSegue", sender: cell)
    }
}

extension MoviesViewController: MovieDataSourceDelegate {
    func dataSource(_ dataSource: MovieDataSource, didFinishFetching movies: [Movie]) {
        self.movies = movies
        self.configureSnapshot()
    }
}

// MARK: Search Bar Delegate
extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        moviesDataSource.getDetailedMovies(for: text)
        
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        moviesDataSource.clearMovies()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            moviesDataSource.clearMovies()
        }
    }
}
