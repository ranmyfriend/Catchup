//
//  TestWrappedHStackView.swift
//  LearnGrid
//
//  Created by BKS-GGS on 01/10/21.
//

import SwiftUI
import LoremSwiftum

/// Author: Azamsharp
/// Youtube: https://www.youtube.com/watch?v=A3zMF8s_YxU
/// Topic: Wrapping HStack in SwiftUI

struct TestWrappedHStackView: View {
//    let words = ["monitor", "program", "💩", "application", "keyboard", "javascript", "gaming", "network", "choose a random element from an array javascript", "getting diff items", "from js list randomly", "select randomly", "from js data array", "elements", "getting diff items", "from js list randomly", "select randomly", "from js data array", "elements"]
    
    let words = Lorem.words(100).split(separator: " ").map { String($0)}
    
    var body: some View {
        TagsView(items: words)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestWrappedHStackView()
    }
}

struct TagsView: View {
    let items: [String]
    var groupedItems: [[String]] = [[String]]()
    let screenWidth = UIScreen.main.bounds.width
    
    init(items: [String]) {
        self.items = items
        self.groupedItems = createGroupedItems(items)
    }
    
    private func createGroupedItems(_ items: [String]) -> [[String]] {
        var groupedItems: [[String]] = [[String]]()
        var tempItems: [String] = [String]()
        var width: CGFloat = 0
        
        for word in items {
            let label = UILabel()
            label.text = word
            label.sizeToFit()
            
            let labelWidth = label.frame.size.width + 32
            
            if (width + labelWidth + 55) < screenWidth {
                width += labelWidth
                tempItems.append(word)
            } else {
                width = labelWidth
                groupedItems.append(tempItems)
                tempItems.removeAll()
                tempItems.append(word)
            }
        }
        groupedItems.append(tempItems)
        return groupedItems
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(groupedItems, id:\.self) {
                    subItems in
                    HStack {
                        ForEach(subItems, id: \.self) { word in
                            Text(word)
                                .fixedSize()
                                .padding()
                                .background(Color.pink)
                                .foregroundColor(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}
