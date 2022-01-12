//
//  HomeView.swift
//  RecipeSaver
//
//  Created by BKS-GGS on 07/01/22.
//

import SwiftUI

struct HomeView: View {
   @EnvironmentObject var recipesViewModel: RecipesViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                RecipeList(recipes: recipesViewModel.recipes)
            }
            .navigationTitle("My Recipes")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(RecipesViewModel())
    }
}
