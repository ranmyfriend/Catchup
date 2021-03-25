//
//  ViewController.swift
//  NetworkResponse
//
//  Created by Ranjit on 24/03/21.
//

import UIKit

struct Search: Decodable {
    let resultCount: Int
    let results: [SearchResult]
}

//Equatable this protocol will make it simple to test with an XCTAssertEqual assertion.
struct SearchResult: Decodable, Equatable {
    let artworkUrl60, artworkUrl100: String
    let artistViewURL: String
    let trackCensoredName: String
    let fileSizeBytes: Int
    let formattedPrice: String
    let trackViewURL: String
    let trackID: Int
    let trackName: String
    let releaseDate: String
    let genreIDS: [String]
    let artistIDS: [Int]
    let currency, resultDescription: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Double
    let kind: String
    let averageUserRating: Double
    let userRatingCount: Int
    
    enum CodingKeys: String, CodingKey {
        case artworkUrl60, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case trackCensoredName, fileSizeBytes, formattedPrice
        case trackViewURL = "trackViewUrl"
        case trackID = "trackId"
        case trackName, releaseDate
        case genreIDS = "genreIds"
        case artistIDS = "artistIds"
        case currency
        case resultDescription = "description"
        case artistID = "artistId"
        case artistName, genres, price, kind, averageUserRating, userRatingCount
    }
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class ViewController: UIViewController {
    
    @IBOutlet private(set) var button: UIButton!
    private var dataTask: URLSessionDataTask?
    var session: URLSessionProtocol = URLSession.shared
    
    //lets move results into new variable and print it
    var handleResults: ([SearchResult]) -> Void = {
        print($0)
    }
    private(set) var results: [SearchResult] = [] {
        didSet {
            handleResults(results)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBAction private func buttonTapped() {
        searchForBook(terms: "out from boneville")
    }
  
    private func searchForBook(terms: String) {
        guard let encodedTerms = terms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://itunes.apple.com/search?" + "media=ebook&term=\(encodedTerms)") else {
            return
        }
        
        let request = URLRequest(url: url)
        //URLSession.shared
        dataTask = session.dataTask(with: request) {
            [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let self = self else { return}
            var decoded: Search?
            var errorMessage: String?
            if let error = error {
                errorMessage = error.localizedDescription
            } else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                errorMessage = "Response: " + HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
            } else if let data = data {
                do {
                    decoded = try JSONDecoder().decode(Search.self, from: data)
                } catch {
                    errorMessage = error.localizedDescription
                }
            }
            DispatchQueue.main.async { [weak self] in
                
                guard let self = self else { return }
                
                if let decoded = decoded {
                    self.results = decoded.results
                }
              
                if let errorMessage = errorMessage {
                    self.showError(errorMessage)
                }
                self.dataTask = nil
                self.button.isEnabled = true
            }
        }
        button.isEnabled = false
        dataTask?.resume()
    }
    
    private func showError(_ message: String) {
        let title = "Network problem"
        print("\(title):\(message)")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        alert.preferredAction = okAction
        present(alert, animated: true)
    }
}

