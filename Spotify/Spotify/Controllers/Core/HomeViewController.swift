//
//  HomeViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done, target: self,
            action: #selector(didTapSettings)
        )
      fetchData()
    }
  
  private func fetchData() {
    APICaller.shared.getRecommendedGenres { result in
      switch result {
      case .success(let model):
        let genres = model.genres
        var seeds = Set<String>()
        while seeds.count < 5 {
          if let random = genres.randomElement() {
            seeds.insert(random)
          }
        }
        
        APICaller.shared.getRecommendations(genres: seeds) { result in
          switch result {
          case .success(let model): break
          case .failure(let error): break
          }
        }
      case .failure(let error): break
      }
    }
  }
    
    @objc func didTapSettings() {
        let settingsViewController = SettingsViewController()
        settingsViewController.title = "Settings"
        settingsViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

}
