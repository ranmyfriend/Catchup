//
//  ContentView.swift
//  Memorize
//
//  Created by BKS-GGS on 01/09/21.
//

import SwiftUI

struct ContentView: View {
  var emojis = ["🚲", "🚂", "🚁","🚜", "🚕", "🛴", "🚑", "🚅",
                "🍖", "🌽", "🍊", "🍓","🍇", "🥥", "🥒","🥝",
                "🏂", "🏀", "🏋️‍♀️", "🏏", "🎱", "🤼‍♂️", "⛹️‍♀️","🚴‍♂️"]
  
 @State var emojiCount = 20
  
  var body: some View {
    VStack {
      ScrollView {
        /* LazyVGrid is completely lazy when accessing the CardView body */
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
          ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
            CardView(content: emoji)
              .aspectRatio(2/3, contentMode: .fit)
          }
        }
      }
      .foregroundColor(.red)
      
      Spacer()
      VStack() {
        HStack {
          Text("Choose your theme?")
            .font(.title)
          Spacer()
        }
        HStack {
        Text("Vehicles")
          Spacer()
          Text("Fruits")
          Spacer()
          Text("Sports")
        }
        .font(.title2)
        .padding()
      }
      .foregroundColor(Color.blue)
    }
    .padding(.horizontal)
    .navigationTitle("Memorize!")
  }
  
  
  var remove: some View {
    Button {
      if emojiCount > 1 {
        emojiCount -= 1
      }
    } label: {
      Image(systemName: "minus.circle")
    }
  }
  
  var add: some View {
    Button {
      if emojiCount < emojis.count {
        emojiCount += 1
      }
    } label: {
      Image(systemName: "plus.circle")
    }
  }
}





struct CardView: View {
  var content: String
 @State var isFaceUp: Bool = true
  
  var body: some View {
    ZStack {
      let shape = RoundedRectangle(cornerRadius: 20)
      if isFaceUp {
        shape.fill().foregroundColor(.white)
        shape.strokeBorder(lineWidth: 3)
        Text(content).font(.largeTitle)
      } else {
        shape.fill()
      }
    }
    .onTapGesture {
      isFaceUp = !isFaceUp
    }
  }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        ContentView()
          .preferredColorScheme(.light)
      }
      NavigationView {
        ContentView()
          .preferredColorScheme(.dark)
      }
    }
}
