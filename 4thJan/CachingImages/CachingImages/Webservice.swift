//
//  Webservice.swift
//  CachingImages
//
//  Created by BKS-GGS on 04/01/22.
//

import Foundation

class Webservice {
    
    func getPhotos() async throws -> [Photo] {
        
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://jsonplaceholder.typicode.com/photos")!)
        return try JSONDecoder().decode([Photo].self, from: data)
    }
}
