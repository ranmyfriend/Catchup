//
//  CategoryView.swift
//  RecipeSaver
//
//  Created by BKS-GGS on 08/01/22.
//

import SwiftUI

struct CategoryView: View {
    var category: Category
    
    // Computed property
    var recipes: [Recipe] {
        Recipe.all.filter { $0.category == category.rawValue}
    }
    var body: some View {
        ScrollView {
       RecipeList( recipes: recipes )}
       .navigationTitle(category.rawValue + "s")
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category.main)
    }
}
