//
//  SampleView.swift
//  Calculator
//
//  Created by BKS-GGS on 31/08/21.
//

import SwiftUI

struct SampleView: View {
  var body: some View {
    TextField("Hello, World!", text: .constant("Howa day"))
      .accessibility(label: Text("SampleView.Hello.World.TextField.Label"))
      .accessibility(value: Text("SampleView.Hello.World.TextField.Value"))
      .accessibility(identifier: "SampleView.Hello.World.TextField.Identifier")
      
      .onAppear {
        print("sampleview loaded")
      }
  }
  
}

struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
    }
}
