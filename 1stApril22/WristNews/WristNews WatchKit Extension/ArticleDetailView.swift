//
//  ArticleDetailView.swift
//  WristNews WatchKit Extension
//
//  Created by BKS-GGS on 01/04/22.
//

import SwiftUI
import Kingfisher
import struct Kingfisher.KFImage

struct ArticleDetailView: View {
    var article: Article
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("By \(article.author)")
                    .fontWeight(.ultraLight)
                
                KFImage(URL(string: article.imageLink))
                    .resizable()
                    .scaledToFit()
                
                Divider()
                
                Text(article.description)
                    .font(.caption)
                    .fontWeight(.ultraLight)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(article.content)
                    .font(.caption)
                    .fontWeight(.ultraLight)
                    .fixedSize(horizontal: false, vertical: true)
                
                Divider()
                
                Text("Published at:\(article.publishedAt)")
                    .font(.caption)
                    .fontWeight(.ultraLight)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("Read the full story in:\(article.link)")
                    .font(.caption)
                    .fontWeight(.ultraLight)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top)
            }
        }
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: Article(
            title: "Rosalía Shares Her All-Time Favorite Songs in a Met Gala–Themed Playlist - Vogue",
            description: "This playlist is a celebratory playlist for the Met, with nods to my all-time favorite songs, sounds, artists, and references. It has not been possible to celebrate the Met as God intended, but we can celebrate it in our own way from home.",
            author: "Estelle Tang",
            link:"https://www.vogue.com/article/rosalia-met-gala-about-time-playlist",
            imageLink: "https://assets.vogue.com/photos/5eb0a75cd5f359c964b7e0e4/16:9/w_1280,c_limit/ GettyImages-1162355675.jpg",
            publishedAt: "2020-05-05T00:20:29Z",
            content: "To commemorate a very different first Monday in May this year, Vogue asked some of our favorite stars to create a playlist featuring timeless songs inspired by the theme of this year's Met gala and the upcoming Costume Institute exhibition, About Time: Fashio… [+2158 chars]"
        ))
    }
}
