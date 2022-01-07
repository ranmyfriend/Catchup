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
            RecipeCard(recipe: Recipe.all[0])
//            Text("Categories")
//                .navigationTitle("Categories")
        }.navigationViewStyle(.stack)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
