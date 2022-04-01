//
//  Article.swift
//  WristNews WatchKit Extension
//
//  Created by BKS-GGS on 01/04/22.
//

import Foundation

struct Article: Hashable, Identifiable {
    var id: String
    var title: String
    var description: String
    var author: String
    var link: String
    var imageLink: String
    var publishedAt: String
    var content: String
    
    init(title: String, description: String, author: String, link: String, imageLink: String, publishedAt: String, content:String){
     self.id = UUID().uuidString
     self.title = title
     self.description = description
     self.author = author
     self.link = link
     self.imageLink = imageLink
     self.publishedAt = publishedAt
     self.content = content
    }
}
