@testable import Spotify
import XCTest

final class TabBarViewControllerTests: XCTestCase {
    
    private var tabBarVC: TabBarViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        tabBarVC = TabBarViewController()
    }
    
    override func tearDownWithError() throws {
        tabBarVC = nil
        try super.tearDownWithError()
    }

    func test_tabBar_homeNavigationController() {
        let homeNC = tabBarVC.homeNavigationController
        XCTAssertNotNil(homeNC, "It should be Navigation controller")
        XCTAssertEqual(homeNC.children.count, 1, "It should have only one View controller")
        let homeVC = homeNC.children.first
        XCTAssertNotNil(homeVC, "It should not be a Nil")
        XCTAssertEqual(homeVC!.title, "Browse", "home view controller title has changed")
        XCTAssertEqual(homeVC?.navigationItem.largeTitleDisplayMode, UINavigationItem.LargeTitleDisplayMode.always, "It should be larger title")
        XCTAssertTrue(homeNC.navigationBar.prefersLargeTitles, "It should be true")
        XCTAssertNotNil(homeNC.tabBarItem, "Navigation controller should have tabBar item")
        XCTAssertEqual(homeNC.tabBarItem.title, "Home", "tabBar item title should be home")
        XCTAssertEqual(homeNC.tabBarItem.image, UIImage(systemName: "house"), "tabBar item image icon should be house")
        XCTAssertEqual(tabBarVC.viewControllers?.first?.title, homeVC?.title, "Home Navigation controller should be top of Tab bar controllers")
    }
    
    func test_tabBar_searchNavigationController() {
        let searchNC = tabBarVC.searchNavigationController
        XCTAssertNotNil(searchNC, "It should be Navigation controller")
        XCTAssertEqual(searchNC.children.count, 1, "It should have only one View controller")
        let searchVC = searchNC.children.first
        XCTAssertNotNil(searchVC, "It should not be a Nil")
        XCTAssertEqual(searchVC!.title, "Search", "search view controller title has changed")
        XCTAssertEqual(searchVC?.navigationItem.largeTitleDisplayMode, UINavigationItem.LargeTitleDisplayMode.always, "It should be larger title")
        XCTAssertTrue(searchNC.navigationBar.prefersLargeTitles, "It should be true")
        XCTAssertEqual(searchVC!.title, "Search", "search view controller title has changed")
        XCTAssertNotNil(searchNC.tabBarItem, "Navigation controller should have tabBar item")
        XCTAssertEqual(searchNC.tabBarItem.image, UIImage(systemName: "magnifyingglass"), "tabBar item image icon should be magnifyingglass")
        XCTAssertEqual(tabBarVC.viewControllers?[1].title, searchVC?.title, "Search Navigation controller should be top of Tab bar controllers")
    }
    
    func test_tabBar_libraryNavigationController() {
        let libraryNC = tabBarVC.libraryNavigationController
        XCTAssertNotNil(libraryNC, "It should be Navigation controller")
        XCTAssertEqual(libraryNC.children.count, 1, "It should have only one View controller")
        let libraryVC = libraryNC.children.first
        XCTAssertNotNil(libraryVC, "It should not be a Nil")
        XCTAssertEqual(libraryVC!.title, "Library", "library view controller title has changed")
        XCTAssertEqual(libraryVC?.navigationItem.largeTitleDisplayMode, UINavigationItem.LargeTitleDisplayMode.always, "It should be larger title")
        XCTAssertTrue(libraryNC.navigationBar.prefersLargeTitles, "It should be true")
        XCTAssertNotNil(libraryNC.tabBarItem, "Navigation controller should have tabBar item")
        XCTAssertEqual(libraryNC.tabBarItem.image, UIImage(systemName: "music.note.list"), "tabBar item image icon should be music.note.list")
        XCTAssertEqual(tabBarVC.viewControllers?[2].title, libraryVC?.title, "Library Navigation controller should be top of Tab bar controllers")
    }
    
    func test_tabBar_viewControllersSetup() {
        XCTAssertEqual(tabBarVC.viewControllers?.count, 3, "Home, Search, Library")
        XCTAssertEqual(tabBarVC.viewControllers?[0].title, tabBarVC.homeNavigationController.title, "It should be home")
        XCTAssertEqual(tabBarVC.viewControllers?[1].title, tabBarVC.searchNavigationController.title, "It should be search")
        XCTAssertEqual(tabBarVC.viewControllers?[2].title, tabBarVC.libraryNavigationController.title, "It should be library")
    }
 
    
}
