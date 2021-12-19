//
//  ViewModifierBootcamp.swift
//  EP1
//
//  Created by BKS-GGS on 19/12/21.
//

import SwiftUI

/* Topic: How to create custom ViewModifiers in SwiftUI | Advanced Learning #1
 Youtube Video Link: https://www.youtube.com/watch?v=MQl4DlDf_5k&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=5
*/
struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

extension View {
    
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifierBootcamp: View {
    
    var body: some View {
        VStack(spacing: 10) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.headline)
                .withDefaultButtonFormatting()
            
            Text("Hello, Everyone!")
                .font(.subheadline)
                .withDefaultButtonFormatting(backgroundColor: .orange)
            
            Text("Hello!!!")
                .font(.title)
                .withDefaultButtonFormatting(backgroundColor: .red)
        }
        .padding()
    }
}

struct ViewModifierBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierBootcamp()
    }
}
