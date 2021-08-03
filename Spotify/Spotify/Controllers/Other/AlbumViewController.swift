//
//  AlbumViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 24/07/21.
//

import UIKit

class AlbumViewController: UIViewController {
  
  private let album: Album
  
  private var viewModels = [AlbumCollectionViewCellViewModel]()
  private var tracks = [AudioTrack]()
  
  private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
    
    //Item
    let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
    item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 2, trailing: 2)
    
    let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60)), subitem: item, count: 1)
    
    //Section
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [
      NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    ]
    return section
    
  }))
  
  init(album: Album) {
    self.album = album
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = album.name
    view.backgroundColor = .systemBackground
    
    view.addSubview(collectionView)
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(AlbumTrackCollectionViewCell.self, forCellWithReuseIdentifier: AlbumTrackCollectionViewCell.identifier)
    collectionView.register(PlaylistHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier)
    collectionView.backgroundColor = .systemBackground
    
    self.fetchAlbumDetails()
    
    //      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
  }
  
  private func fetchAlbumDetails() {
    APICaller.shared.getAlbumDetails(for: self.album) { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let value):
          self?.tracks = value.tracks.items
          self?.viewModels = value.tracks.items.compactMap({AlbumCollectionViewCellViewModel(name: $0.name, artistName: $0.artists.first?.name ?? "-", artworkURL: URL(string: $0.album?.images.first?.url ?? ""))})
          self?.collectionView.reloadData()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.frame
  }
  
}


extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumTrackCollectionViewCell.identifier, for: indexPath) as? AlbumTrackCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.configure(with: viewModels[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionHeader,
          let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier, for: indexPath) as? PlaylistHeaderCollectionReusableView else {
      return UICollectionReusableView()
    }
    let headerViewModel = PlaylistHeaderViewViewModel(name: album.name, ownerName: album.artists.first?.name, description: "Release Date: \(String.formattedDate(string: album.release_date))", artworkURL: URL(string: album.images.first?.url ?? ""))
        header.configure(with: headerViewModel)
        header.delegate = self
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    PlaybackPresenter.startPlayback(from: self, track: tracks[indexPath.row])
  }
  
  
}


extension AlbumViewController: PlaylistHeaderCollectionReusableViewDelegate {
  func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
    PlaybackPresenter.startPlayback(from: self, tracks: tracks)
  }
}
