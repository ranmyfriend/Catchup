//
//  LibraryPlaylistsViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 07/08/21.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {
  
  var playlists = [Playlist]()
  
  public var selectionHandler: ((Playlist) -> Void)?
  
  private let noPlaylistsView = ActionLabelView()
  
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.register(SearchResultSubtitleDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleDefaultTableViewCell.identifier)
    tableView.isHidden = true
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(noPlaylistsView)
    
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    view.backgroundColor = .systemBackground
    
    setupNoPlaylistsView()
    fetchData()
    
    if selectionHandler != nil {
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
  }
  
  @objc private func didTapClose() {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.frame = view.bounds
    
    noPlaylistsView.frame = CGRect(x: (view.width-150)/2, y: (view.height-150)/2, width: 150, height: 150)
  }
  
  private func fetchData() {
    APICaller.shared.getCurrentUserPlaylist { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let playlists):
          self?.playlists = playlists
          self?.updateUI()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
  
  private func setupNoPlaylistsView() {
    noPlaylistsView.delegate = self
    noPlaylistsView.configure(with: ActionLabelViewViewModel(text: "You don't have any playlists yet.", actionTitle: "Create"))
  }
  
  private func updateUI() {
    if playlists.isEmpty {
      noPlaylistsView.isHidden = false
      self.tableView.isHidden = true
    } else {
      noPlaylistsView.isHidden = true
      self.tableView.isHidden = false
      self.tableView.reloadData()
    }
  }
  
  public func showCreatePlaylistAlert() {
    //Show creation UI
    let alert = UIAlertController(title: "New Playlists", message: "Enter playlist name", preferredStyle: .alert)
    alert.addTextField { txtField in
      txtField.placeholder = "Playlists..."
    }
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    alert.addAction(UIAlertAction(title: "Create", style: .default, handler: {_ in
      guard let field = alert.textFields?.first,
            let text = field.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
        return
      }
      APICaller.shared.createPlaylist(with: text) { success in
        if success {
          HapticsManager.shared.vibrate(for: .success)
          //Refresh list of playlists
        } else {
          HapticsManager.shared.vibrate(for: .error)
          print("Failed to create playlist")
        }
      }
    }))
    present(alert, animated: true, completion: nil)
  }
  
}

extension LibraryPlaylistsViewController: ActionLabelViewDelegate {
  func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
    showCreatePlaylistAlert()
  }
}

extension LibraryPlaylistsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return playlists.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleDefaultTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleDefaultTableViewCell else {
      return UITableViewCell()
    }
    let playlist = playlists[indexPath.row]
    cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: playlist.name, subtitle: playlist.owner.display_name, imageURL: URL(string: playlist.images.first?.url ?? "")))
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    HapticsManager.shared.vibrateForSelection()
    let playlist = playlists[indexPath.row]
    guard selectionHandler == nil else {
      selectionHandler?(playlist)
      dismiss(animated: true, completion: nil)
      return
    }
    let playListViewController = PlaylistViewController(playlist: playlist)
    playListViewController.navigationItem.largeTitleDisplayMode = .never
    playListViewController.isOwner = true
    navigationController?.pushViewController(playListViewController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
}
