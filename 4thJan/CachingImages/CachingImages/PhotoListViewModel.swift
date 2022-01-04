//
//  PhotoListViewModel.swift
//  CachingImages
//
//  Created by BKS-GGS on 04/01/22.
//

import Foundation

@MainActor //Declared MainActor means `photos` and `populatePhotos` function should get called on the MainThread :)
class PhotoListViewModel: ObservableObject {
    
    @Published var photos: [PhotoViewModel] = []
    
    func populatePhotos() async {
        do {
            let photos = try await Webservice().getPhotos()
            self.photos = photos.map(PhotoViewModel.init)
        } catch {
            print(error)
        }
    }
}

struct PhotoViewModel: Identifiable {
    
    private var photo: Photo
    let id = UUID()
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    var title: String {
        photo.title
    }
    
    var thumbnailUrl: URL? {
        URL(string: photo.thumbnailUrl)
    }

}
