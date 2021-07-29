//
//  SearchViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

class SearchViewController: UIViewController {
  
  let searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: SearchResultsViewController())
    searchController.searchBar.placeholder = "Songs, Artists, Albums"
    searchController.searchBar.searchBarStyle = .minimal
    searchController.definesPresentationContext = true
    return searchController
  }()

  private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
    
    let item = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(1)
      )
    )
    
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .absolute(150)
      ),
      subitem: item,
      count: 2
    )
    
    group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)

    
    return NSCollectionLayoutSection(group: group)
  }))
  
  // Mark: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
      searchController.searchResultsUpdater = self
      navigationItem.searchController = searchController
      view.addSubview(collectionView)
      collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.backgroundColor = .systemBackground
    }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
}


extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
          let query = searchController.searchBar.text,
          !query.trimmingCharacters(in: .whitespaces).isEmpty else {
      return
    }
    // res
    //Perform search
    print("query:\(query)")
  }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.configure(with: "Rock")
    return cell
  }
}
