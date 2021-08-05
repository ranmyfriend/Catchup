//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by BKS-GGS on 03/08/21.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource: AnyObject{
  var songName: String? { get }
  var subtitle: String? { get }
  var imageURL: URL? { get }
}

final class PlaybackPresenter {
  
  static let shared = PlaybackPresenter()
  
  private var track: AudioTrack?
  private var playerQueue: AVQueuePlayer?
  private var tracks = [AudioTrack]()
  
  var index = 0
  
  var currentTrack: AudioTrack? {
    if let track = track, tracks.isEmpty {
      return track
    } else if let player = self.playerQueue, !tracks.isEmpty {
      return tracks[index]
    }
    return nil
  }
  
  var playerVC: PlayerViewController?
  
  var player: AVPlayer?
  
  func startPlayback(from viewController: UIViewController, track: AudioTrack) {
    guard let url = URL(string: track.preview_url ?? "") else {
      return
    }
    player = AVPlayer(url: url)
    player?.volume = 0.0
    self.track = track
    self.tracks = []
    let playerViewController = PlayerViewController()
    playerViewController.title = track.name
    playerViewController.dataSource = self
    playerViewController.delegate = self
    viewController.present(UINavigationController(rootViewController: playerViewController), animated: true, completion: {[weak self] in
      self?.player?.play()
    })
    self.playerVC = playerViewController
  }
  
  func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
    self.tracks = tracks
    let items: [AVPlayerItem] = self.tracks.compactMap({guard let url = URL(string: $0.preview_url ?? "") else {
      return nil
    }
    return AVPlayerItem(url: url)
    })
    playerQueue = AVQueuePlayer(items: items)
    playerQueue?.volume = 0.0
    playerQueue?.play()
    let playerViewController = PlayerViewController()
    playerViewController.dataSource = self
    playerViewController.delegate = self
    viewController.present(UINavigationController(rootViewController: playerViewController), animated: true, completion: { [weak self] in
      self?.playerQueue?.play()
    })
    self.playerVC = playerViewController
  }
  
}


extension PlaybackPresenter: PlayerDataSource {
  var songName: String? {
    return currentTrack?.name
  }
  
  var subtitle: String? {
    return currentTrack?.artists.first?.name
  }
  
  var imageURL: URL? {
    return URL(string: currentTrack?.album?.images.first?.url ?? "")
  }
  
  
}


extension PlaybackPresenter: PlayerViewControllerDelegate {
  func didTapPlayPause() {
    if let player = player {
      if player.timeControlStatus == .playing {
        player.pause()
      } else if player.timeControlStatus == .paused {
        player.play()
      }
    } else if let player = playerQueue {
      if player.timeControlStatus == .playing {
        player.pause()
      } else if player.timeControlStatus == .paused {
        player.play()
      }
    }
  }
  
  func didTapForward() {
    if tracks.isEmpty {
      // Not playlist or album
      player?.pause()
    } else if let player = playerQueue {
      player.advanceToNextItem()
      index += 1
      playerVC?.refreshUI()
    }
  }
  
  func didTapBackward() {
    if tracks.isEmpty {
      // Not playlist or album
      player?.pause()
      player?.play()
    } else if let firstItem = playerQueue?.items().first {
      playerQueue?.pause()
      playerQueue?.removeAllItems()
      playerQueue = AVQueuePlayer(items: [firstItem])
      playerQueue?.play()
      playerQueue?.volume = 0.0
    }
  }
  
  func didSlideSlider(value: Float) {
    if let player = player {
      player.volume = value
    }
  }
  
  
}
