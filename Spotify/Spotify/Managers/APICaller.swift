//
//  APICaller.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
  
  //MARK: - Album Details
  
  public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponse, Error>) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/albums/" + album.id), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
          guard let data = data, error == nil else {
              completion(.failure(APIError.failedToGetData))
              return
          }
          
          do {
              let result = try JSONDecoder().decode(AlbumDetailsResponse.self, from: data)
              completion(.success(result))
          } catch {
              completion(.failure(error))
          }
      }
      task.resume()
    }
  }
  
  //MARK: - Playlist Details
  
  public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
          guard let data = data, error == nil else {
              completion(.failure(APIError.failedToGetData))
              return
          }
          
          do {
              let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
              completion(.success(result))
          } catch {
            print(error)
              completion(.failure(error))
          }
      }
      task.resume()
    }
  }
  
  public func getCurrentUserPlaylist(completion: @escaping (Result<[Playlist], Error>) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/me/playlists/?limit=50"), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
          guard let data = data, error == nil else {
              completion(.failure(APIError.failedToGetData))
              return
          }
          
          do {
              let result = try JSONDecoder().decode(LibraryPlaylistsResponse.self, from: data)
            completion(.success(result.items))
          } catch {
            print(error)
              completion(.failure(error))
          }
      }
      task.resume()
    }
  }
  
  public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void) {
    getCurrentUserProfile { [weak self] result in
      switch result {
      case .success(let profile):
        let urlString = Constants.baseAPIURL + "/users/\(profile.id)/playlists"
        
        self?.createRequest(with: URL(string: urlString), type: .POST) { baseRequest in
          var request = baseRequest
          let json = [
            "name": name
          ]
          request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed )
          let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
              completion(false)
              return
            }
            
            do {
              let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
              if let responseAdDictionary = result as? [String: Any], responseAdDictionary["id"] as? String != nil {
                print("Created")
                completion(true)
              } else {
                print("Failed to get id")
                completion(false)
              }
            } catch {
              print(error)
              completion(false)
            }
          }
          task.resume()
        }
      case .failure(let error):
      print(error.localizedDescription)
      }
      
    }
  }
  
  public func addTrackToPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Result<Bool, Error>) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/"), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
          guard let data = data, error == nil else {
              completion(.failure(APIError.failedToGetData))
              return
          }
          
          do {
              let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
//              completion(.success(result))
          } catch {
            print(error)
              completion(.failure(error))
          }
      }
      task.resume()
    }
  }
  
  public func removeTrackFromPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
          guard let data = data, error == nil else {
              completion(.failure(APIError.failedToGetData))
              return
          }
          
          do {
              let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
              completion(.success(result))
          } catch {
            print(error)
              completion(.failure(error))
          }
      }
      task.resume()
    }
  }
    
  //MARK: - User Profile
  
    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
  //MARK: - New Releases
  
  public func getNewReleases(completion: @escaping ((Result<NewReleasesResponse, Error>)) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
          completion(.success(result))
        } catch {
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  //MARK: - Featured Playlist
  
  public func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistsResponse, Error>)) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
          completion(.success(result))
        } catch {
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  // MARK: - Recommendations

  public func getRecommendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsResponse, Error>)) -> Void) {
    let seeds = genres.joined(separator: ",")
    createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
          completion(.success(result))
        } catch {
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  // MARK: - Recommended Genres

  public func getRecommendedGenres(completion: @escaping ((Result<RecommededGenresResponse, Error>)) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let result = try JSONDecoder().decode(RecommededGenresResponse.self, from: data)
          completion(.success(result))
        } catch {
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  // MARK: - Category
  
  public func getCategories(completion: @escaping ((Result<[Category], Error>)) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=50"),
                  type: .GET
    ) { request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
          completion(.success(result.categories.items))
        } catch {
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  // MARK: - Category PlayList

  public func getCategoryPlaylist(category: Category, completion: @escaping ((Result<[Playlist], Error>)) -> Void) {
    createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists?limit=50"),
                  type: .GET
    ) { request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
            let result = try JSONDecoder().decode(CategoryPlaylistsResponse.self, from: data)
          completion(.success(result.playlists.items))
        } catch {
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  // MARK: - Search
  
  public func search(with query: String, completion: @escaping ((Result<[SearchResult], Error>)) -> Void) {
    createRequest(
      with: URL(string: Constants.baseAPIURL + "/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
      type: .GET
    ) { request in
      print("Search Query:\(request.url?.absoluteString ?? "none")")
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let result = try JSONDecoder().decode(SearchResultsResponse.self, from: data)
          var searchResults: [SearchResult] = []
          searchResults.append(contentsOf: result.tracks.items.compactMap({SearchResult.track(model: $0)}))
          searchResults.append(contentsOf: result.albums.items.compactMap({SearchResult.album(model: $0)}))
          searchResults.append(contentsOf: result.playlists.items.compactMap({SearchResult.playlist(model: $0)}))
          searchResults.append(contentsOf: result.artists.items.compactMap({SearchResult.artist(model: $0)}))
          completion(.success(searchResults))
        } catch {
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
 
  // MARK: - Private
    enum HTTPMethod: String {
        case GET
        case POST
    }
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { (token) in
            guard let url = url else {
                return
            }
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
