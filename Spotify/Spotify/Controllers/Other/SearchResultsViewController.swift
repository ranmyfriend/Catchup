//
//  SearchResultsViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

struct SearchSection {
  let title: String
  let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
  func didTapResult(_ result: SearchResult)
}

class SearchResultsViewController: UIViewController {
  
  private var sections: [SearchSection] = []
  
  weak var delegate: SearchResultsViewControllerDelegate?
  
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.register(SearchResultDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultDefaultTableViewCell.identifier)
    tableView.register(SearchResultSubtitleDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleDefaultTableViewCell.identifier)
    tableView.isHidden = true
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.tableView.frame = view.bounds
  }
  
  func update(with results: [SearchResult]) {
    let artists = results.filter ({
      switch $0 {
      case .artist: return true
      default: return false
      }
    })
    let playlists = results.filter ({
      switch $0 {
      case .playlist: return true
      default: return false
      }
    })
    let albums = results.filter ({
      switch $0 {
      case .album: return true
      default: return false
      }
    })
    let tracks = results.filter ({
      switch $0 {
      case .track: return true
      default: return false
      }
    })
    self.sections = [
      SearchSection(title: "Songs", results: tracks),
      SearchSection(title: "Artists", results: artists),
      SearchSection(title: "Albums", results: albums),
      SearchSection(title: "Playlists", results: playlists)
    ]
    
    tableView.reloadData()
    tableView.isHidden = results.isEmpty
  }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].results.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let result = sections[indexPath.section].results[indexPath.row]
    switch result {
    case .artist(let model):
      guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultDefaultTableViewCell.identifier, for: indexPath) as? SearchResultDefaultTableViewCell else {
        return UITableViewCell()
      }
      let viewModel = SearchResultDefaultTableViewCellViewModel(title: model.name, imageURL: URL(string: model.images?.first?.url ?? ""))
      cell.configure(with: viewModel)
      return cell
    case .album(let model):
      guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleDefaultTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleDefaultTableViewCell else {
        return UITableViewCell()
      }
      let viewModel = SearchResultSubtitleTableViewCellViewModel(title: model.name, subtitle: model.artists.first?.name ?? "", imageURL: URL(string: model.images.first?.url ?? ""))
      cell.configure(with: viewModel)
      return cell
    case .playlist(let model):
      guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleDefaultTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleDefaultTableViewCell else {
        return UITableViewCell()
      }
      let viewModel = SearchResultSubtitleTableViewCellViewModel(title: model.name, subtitle: model.owner.display_name, imageURL: URL(string: model.images.first?.url ?? ""))
      cell.configure(with: viewModel)
      return cell

    case .track(let model):
      guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleDefaultTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleDefaultTableViewCell else {
        return UITableViewCell()
      }
      let viewModel = SearchResultSubtitleTableViewCellViewModel(title: model.name, subtitle: model.artists.first?.name ?? "", imageURL: URL(string: model.album?.images.first?.url ?? ""))
      cell.configure(with: viewModel)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].title
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let result = sections[indexPath.section].results[indexPath.row]
    delegate?.didTapResult(result)
  }
  
}
