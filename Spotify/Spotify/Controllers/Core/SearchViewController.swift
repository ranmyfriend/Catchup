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
  
  private var categories = [Category]()
  
  // Mark: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    searchController.searchResultsUpdater = self
    navigationItem.searchController = searchController
    view.addSubview(collectionView)
    collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .systemBackground
    
    APICaller.shared.getCategories { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let categories):
          self?.categories = categories
          self?.collectionView.reloadData()
        case .failure(let error):
          print(error.localizedDescription)
          break
        }
      }
    }
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
    return categories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
      return UICollectionViewCell()
    }
    let category = categories[indexPath.row]
    cell.configure(with: CategoryCollectionViewCellViewModel(title: category.name, artworkURL: URL(string: category.icons.first?.url ?? "")))
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let category = categories[indexPath.row]
    let categoryViewController = CategoryViewController(category: category)
    self.navigationController?.pushViewController(categoryViewController, animated: true)
  }
  
}
