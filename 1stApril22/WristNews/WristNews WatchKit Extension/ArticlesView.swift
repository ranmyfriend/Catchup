//
//  ArticlesView.swift
//  WristNews WatchKit Extension
//
//  Created by BKS-GGS on 01/04/22.
//

import SwiftUI

struct ArticlesView: View {
    @ObservedObject var articleManager = ArticleFetcher()
    
    var body: some View {
        VStack {
            Text("Articles")
            if articleManager.fetchError == true {
                Text("There was an error while fetching your news")
                    .multilineTextAlignment(.center)
                
                Button {
                    self.articleManager.fetchArticles()
                } label: {
                    Text("Try Again")
                }
            } else {
                List(articleManager.articles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        ArticleRow(article: article)
                    }
                }
            }
        }.onAppear {
            self.articleManager.fetchArticles()
        }
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
