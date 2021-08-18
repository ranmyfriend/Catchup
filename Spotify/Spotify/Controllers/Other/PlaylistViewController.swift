//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

class PlaylistViewController: UIViewController {

  private let playlist: Playlist
  private var viewModels = [RecommendedTrackCellViewModel]()
  private var tracks = [AudioTrack]()
  public var isOwner = false
  
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
   
   init(playlist: Playlist) {
     self.playlist = playlist
     super.init(nibName: nil, bundle: nil)
   }
   required init?(coder: NSCoder) {
     fatalError()
   }
     override func viewDidLoad() {
         super.viewDidLoad()
       self.title = playlist.name
       view.backgroundColor = .systemBackground
      
      view.addSubview(collectionView)
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
      collectionView.register(PlaylistHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier)
      collectionView.backgroundColor = .systemBackground
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
      
      let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
      self.collectionView.addGestureRecognizer(longPressGesture)
      self.fetchPlaylistDetails()
     }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.frame
  }
  
  private func fetchPlaylistDetails() {
    APICaller.shared.getPlaylistDetails(for: self.playlist) { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let value):
          self?.tracks = value.tracks.items.compactMap({$0.track})
          self?.viewModels = value.tracks.items.compactMap({RecommendedTrackCellViewModel(name: $0.track.name, artistName: $0.track.artists.first?.name ?? "", artworkURL: URL(string: $0.track.album?.images.first?.url ?? ""))})
          self?.collectionView.reloadData()
        case .failure(let error):
          print(error.localizedDescription)
          break
        }
      }
    }
  }
  
  @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
    guard gesture.state == .began else {
      return
    }
    
    let touchPoint = gesture.location(in: collectionView)
    guard let indexPath = collectionView.indexPathForItem(at: touchPoint) else {
      return
    }
    
    let trackToDelete = tracks[indexPath.row]
    let alerController = UIAlertController(title: trackToDelete.name, message: "Would you like to remove this from playlist?", preferredStyle: .actionSheet)
    alerController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    alerController.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: {[weak self] _ in
      guard let strongSelf = self else {
        return
      }
      APICaller.shared.removeTrackFromPlaylist(track: trackToDelete, playlist: strongSelf.playlist) { success in
        DispatchQueue.main.async {
          if success {
            strongSelf.tracks.remove(at: indexPath.row)
            strongSelf.viewModels.remove(at: indexPath.row)
            strongSelf.collectionView.reloadData()
            print("Track removed")
          } else {
            print("failed to removed")
          }
        }
      }
    }))
    present(alerController, animated: true, completion: nil)
    
  }
  
  @objc func didTapShare() {
    guard let url = URL(string: playlist.external_urls["spotify"] ?? "") else {
      return
    }
    let activityViewController = UIActivityViewController(activityItems: ["Check out this cool playlist I found!",url], applicationActivities: [])
    activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(activityViewController, animated: true)
  }
  
}


extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier, for: indexPath) as? RecommendedTrackCollectionViewCell else {
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
    let headerViewModel = PlaylistHeaderViewViewModel(name: playlist.name, ownerName: playlist.owner.display_name, description: playlist.description, artworkURL: URL(string: playlist.images.first?.url ?? ""))
    header.configure(with: headerViewModel)
    header.delegate = self
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    PlaybackPresenter.shared.startPlayback(from: self, track: self.tracks[indexPath.row])
  }
 
}


extension PlaylistViewController: PlaylistHeaderCollectionReusableViewDelegate {
  func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
    PlaybackPresenter.shared.startPlayback(from: self, tracks: tracks)
  }
}
