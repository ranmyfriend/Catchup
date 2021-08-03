//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by BKS-GGS on 03/08/21.
//

import Foundation
import UIKit

final class PlaybackPresenter {
  
  static func startPlayback(from viewController: UIViewController, track: AudioTrack) {
    let playerViewController = PlayerViewController()
    playerViewController.title = track.name
    viewController.present(UINavigationController(rootViewController: playerViewController), animated: true, completion: nil)
  }
  
  static func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
    let playerViewController = PlayerViewController()
    viewController.present(UINavigationController(rootViewController: playerViewController), animated: true, completion: nil)
  }
  
  
}
