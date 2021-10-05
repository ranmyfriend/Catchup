//
//  ContentView-2.swift
//  SwiftUI-2.0-NewFeatures
//
//  Created by BKS-GGS on 05/10/21.
//

import SwiftUI

/// ScrollView API Update scroll to bottom

struct ContentView_2: View {
    @State var msg: String = ""
    @State var msgs: [Message] = [.init(id: 0, msg: "Initial")]
    
    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { reader in
                    ForEach(self.msgs) { msg in
                        HStack {
                            Text(msg.msg)
                            Spacer()
                        }
                        .padding()
                        .onAppear {
                            // when ever a new data is appeared the scroll will go down
                            // id to scroll to..
                            // Each time the new messages added to var array, the scroll is moving to the bottom
                            reader.scrollTo(self.msgs.count - 1)
                        }
                    }
                }
            }
            
            HStack(spacing: 15) {
                TextField("Message", text: self.$msg)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Send") {
                    // while adding new msg the scroll will go down...
                    
                    // next id
                    self.msgs.append(Message(id: self.msgs.count, msg: self.msg))
                    self.msg = ""
                }
            }
            .padding()
        }
    }
}

struct Message: Identifiable {
    var id: Int
    var msg: String
}

struct ContentView_2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_2()
    }
}
