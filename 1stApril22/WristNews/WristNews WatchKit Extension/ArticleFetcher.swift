//
//  ArticleFetcher.swift
//  WristNews WatchKit Extension
//
//  Created by BKS-GGS on 01/04/22.
//

import SwiftUI
import SwiftyJSON
import Alamofire

public class ArticleFetcher: ObservableObject{
    @Published var articles: [Article] = []
    @Published var fetchError: Bool = false
    
    let myApiKey = "f703ff231f214bc68a24ff2d6b216e0c"
    
    func fetchArticles(){
        self.fetchError = false
        AF.request("https://newsapi.org/v2/top-headlines?language=en&apiKey="+myApiKey).responseJSON{ response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let articles = json["articles"].array ?? []
                var articleArray: [Article] = []
                for item in articles {
                    let title = item["title"].string ?? "Untitled Article"
                    let author = item["author"].string ?? "No author data"
                    let description = item["description"].string ?? "No description"
                    let link = item["url"].string ?? ""
                    let imageLink = item["urlToImage"].string ?? "https://via.placeholder.com/50x50.png?text=IMG"
                    let publishedAt = item["publishedAt"].string ?? "No version data"
                    let content = item["content"].string ?? "No article content"
                    let articleItem = Article(title: title, description: description, author: author, link: link, imageLink: imageLink, publishedAt: publishedAt, content: content)
                    articleArray.append(articleItem)
                }
                self.articles = articleArray
                
            case .failure(let error):
                print(error)
                self.fetchError = true
            }
        }
    }
}
