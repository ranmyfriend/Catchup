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
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
      SearchSection(title: "Artists", results: artists),
      SearchSection(title: "Albums", results: albums),
      SearchSection(title: "Playlists", results: playlists),
      SearchSection(title: "Tracks", results: tracks)
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let result = sections[indexPath.section].results[indexPath.row]
    let txtLabel: String!
    switch result {
    case .artist(let model):
      txtLabel = model.name
    case .album(let model):
      txtLabel = model.name
    case .playlist(let model):
      txtLabel = model.name
    case .track(let model):
      txtLabel = model.name
    }
    cell.textLabel?.text = txtLabel
    return cell
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
