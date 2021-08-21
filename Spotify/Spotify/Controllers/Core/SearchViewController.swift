//
//  SearchViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit
import SafariServices

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
    searchController.searchBar.delegate = self
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
    HapticsManager.shared.vibrateForSelection()
    let category = categories[indexPath.row]
    let categoryViewController = CategoryViewController(category: category)
    self.navigationController?.pushViewController(categoryViewController, animated: true)
  }
  
}


extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {

  }
}


extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
          let query = searchBar.text,
          !query.trimmingCharacters(in: .whitespaces).isEmpty else {
      return
    }
    resultsController.delegate = self
    APICaller.shared.search(with: query) { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let results):
          resultsController.update(with: results)
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}

extension SearchViewController: SearchResultsViewControllerDelegate {
  func didTapResult(_ result: SearchResult) {
    switch result {
    case .artist(let model):
      guard let url = URL(string: model.external_urls["spotify"] ?? "") else {
        return
      }
      let safariViewController = SFSafariViewController(url: url)
      present(safariViewController, animated: true)
    case .album(let model):
    let albumViewController = AlbumViewController(album: model)
      albumViewController.navigationItem.largeTitleDisplayMode = .never
      self.navigationController?.pushViewController(albumViewController, animated: true)
    case .playlist(let model):
      let playlistViewController = PlaylistViewController(playlist : model)
      playlistViewController.navigationItem.largeTitleDisplayMode = .never
      self.navigationController?.pushViewController(playlistViewController, animated: true)
    case .track(let model):
      PlaybackPresenter.shared.startPlayback(from: self, track: model)
    }
  }
}
