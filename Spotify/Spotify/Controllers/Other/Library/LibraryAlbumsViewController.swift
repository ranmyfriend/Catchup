//
//  LibraryAlbumsViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 07/08/21.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {

  var albums = [Album]()
    
  private let noAlbumsView = ActionLabelView()
  
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.register(SearchResultSubtitleDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleDefaultTableViewCell.identifier)
    tableView.isHidden = true
    return tableView
  }()
  
  private var observer: NSObjectProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(noAlbumsView)
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    view.backgroundColor = .systemBackground
    
    setupNoAlbumsView()
    fetchData()
    
    observer = NotificationCenter.default.addObserver(forName: .albumSavedNotification, object: nil, queue: .main, using: { [weak self] _ in
      self?.fetchData()
    })

  }
  
  @objc private func didTapClose() {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    noAlbumsView.frame = CGRect(x: (view.width-150)/2, y: (view.height-150)/2, width: 150, height: 150)
//    noAlbumsView.center = view.center
    tableView.frame = view.bounds
  }
  
  private func fetchData() {
    albums.removeAll()
    APICaller.shared.getCurrentUserAlbums { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let albums):
          self?.albums = albums
          self?.updateUI()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
  
  private func setupNoAlbumsView() {
    noAlbumsView.delegate = self
    noAlbumsView.configure(with: ActionLabelViewViewModel(text: "You have not saved any albums yet.", actionTitle: "Browse"))
  }
  
  private func updateUI() {
    if albums.isEmpty {
      noAlbumsView.isHidden = false
      self.tableView.isHidden = true
    } else {
      noAlbumsView.isHidden = true
      self.tableView.isHidden = false
      self.tableView.reloadData()
    }
  }
  
  
}

extension LibraryAlbumsViewController: ActionLabelViewDelegate {
  func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
    tabBarController?.selectedIndex = 0
  }
}

extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albums.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleDefaultTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleDefaultTableViewCell else {
      return UITableViewCell()
    }
    let album = albums[indexPath.row]
    cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: album.name, subtitle: album.artists.first?.name ?? "-", imageURL: URL(string: album.images.first?.url ?? "")))
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    HapticsManager.shared.vibrateForSelection()
    let album = albums[indexPath.row]
    let albumViewController = AlbumViewController(album: album)
    albumViewController.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(albumViewController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
}
