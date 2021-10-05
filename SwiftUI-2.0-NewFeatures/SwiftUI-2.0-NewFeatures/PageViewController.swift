//
//  PageViewController.swift
//  SwiftUI-2.0-NewFeatures
//
//  Created by BKS-GGS on 05/10/21.
//

import SwiftUI

struct PageViewController: View {
    var body: some View {
        TabView {
            Color.red
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Color.yellow
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Color.blue
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Color.purple
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        // to hide indicator : indexDisplayMode: .never
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct PageViewController_Previews: PreviewProvider {
    static var previews: some View {
        PageViewController()
    }
}
