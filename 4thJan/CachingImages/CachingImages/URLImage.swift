//
//  URLImage.swift
//  CachingImages
//
//  Created by BKS-GGS on 04/01/22.
//

import Foundation
import SwiftUI

struct URLImage: View {
    
    let url: URL?
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack {
            if let uiImage = imageLoader.uiImage {
                Image(uiImage: uiImage)
            } else {
                ProgressView("Loading...")
            }
        }.task {
            await downloadImage()
        }
    }
    
    private func downloadImage() async {
        do {
            try await imageLoader.fetchImage(url)
        } catch {
            print(error)
        }
    }
}
