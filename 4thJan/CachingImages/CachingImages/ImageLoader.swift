//
//  ImageLoader.swift
//  CachingImages
//
//  Created by BKS-GGS on 04/01/22.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case baseRequest
    case unsupportedImage
    case badUrl
}

@MainActor
class ImageLoader: ObservableObject {
    
    @Published var uiImage: UIImage?
    private static let cache = NSCache<NSString, UIImage>()
    
    func fetchImage(_ url: URL?) async throws {
        
        guard let url = url else {
            throw NetworkError.badUrl
        }
        
        let request = URLRequest(url: url)
        
        // check in cache
        if let cachedImage = Self.cache.object(forKey: url.absoluteString as NSString) {
            uiImage = cachedImage
        } else {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.baseRequest
            }
            
            guard let image = UIImage(data: data) else {
                throw NetworkError.unsupportedImage
            }
            
            // store it in cache
            Self.cache.setObject(image, forKey: url.absoluteString as NSString)
            
            uiImage = image
        }
    }
}
