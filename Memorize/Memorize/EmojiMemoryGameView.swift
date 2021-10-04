//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by BKS-GGS on 01/09/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    /// @ObservedObject is a Property Wrapper and we have made the viewModel has Observed one. so it has some published object. So whenever there is some change in viewModel, automatically the view is going to recreated :) MVVM
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            /* LazyVGrid is completely lazy when accessing the CardView body */
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0) //Faded the view
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
