//
//  CategoriesView.swift
//  RecipeSaver
//
//  Created by BKS-GGS on 07/01/22.
//

import SwiftUI

struct CategoriesView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(Category.allCases) {
                    category in
                    NavigationLink(
                        destination: CategoryView(category: category)
                    ) {
                        Text(category.rawValue + "s")
                    }
                }
            }
            .navigationTitle("Categories")
        }.navigationViewStyle(.stack)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
