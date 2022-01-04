//
//  ContentView.swift
//  CachingImages
//
//  Created by BKS-GGS on 04/01/22.
//

import SwiftUI

/*
 Topic: Caching Images in SwiftUI
 URL: https://www.youtube.com/watch?v=eNOT0Fyswbc
 */

struct ContentView: View {
    
    @StateObject private var photoListVM = PhotoListViewModel()
    
    var body: some View {
        NavigationView {
            List(photoListVM.photos) { photo in
                HStack {
                    //AsyncImage(url: photo.thumbnailUrl) //This AsyncImage is built in Library of Swift
                    URLImage(url: photo.thumbnailUrl)
                    Text(photo.title)
                }
            }.task {
                //Here is the place we are calling the network call to fetch photos
                await photoListVM.populatePhotos()
            }
            .navigationTitle("Photos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
