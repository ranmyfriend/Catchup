//
//  TabBarViewController.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var homeNavigationController: UINavigationController {
        let homeViewController = HomeViewController()
        homeViewController.title = "Browse"
        homeViewController.navigationItem.largeTitleDisplayMode = .always
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.navigationBar.prefersLargeTitles = true
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        return homeNavigationController
    }
    
    var searchNavigationController: UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.navigationItem.largeTitleDisplayMode = .always
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchNavigationController.navigationBar.prefersLargeTitles = true
        searchNavigationController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1
        )
        return searchNavigationController
    }
    
    var libraryNavigationController: UINavigationController {
        let libraryViewController = LibraryViewController()
        libraryViewController.title = "Library"
        libraryViewController.navigationItem.largeTitleDisplayMode = .always
        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
        libraryNavigationController.navigationBar.prefersLargeTitles = true
        libraryNavigationController.tabBarItem = UITabBarItem(
            title: "Library",
            image: UIImage(systemName: "music.note.list"),
            tag: 1
        )
        return libraryNavigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print(">> \(#function) called")
        viewControllersSetup()
    }
    
    private func viewControllersSetup() {
        setViewControllers(
            [
                homeNavigationController,
                searchNavigationController,
                libraryNavigationController
            ],
            animated: false
        )
        
        print(">> \(#function) called")
    }

}