//
//  RecipeModel.swift
//  RecipeSaver
//
//  Created by BKS-GGS on 07/01/22.
//

import Foundation

enum Category: String {
    case breakfast = "Breakfast"
    case soup = "Soup"
    case salad = "Salad"
    case appetizer = "Appetizer"
    case main = "Main"
    case side = "Side"
    case dessert = "Dessert"
    case snack = "Snack"
    case drink = "Drink"
}

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let description: String
    let ingredients: String
    let directions: String
    let category: Category.RawValue
    let datePublished: String
    let url: String
}

extension Recipe {
    static let all: [Recipe] = [
        Recipe(
            name: "DAN DAN MIAN NOODLES",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/25314/Dan-Dan-Mian-Noodles-WP-335x189-c.jpg",
            description: "This is a fast, filling dish that shows the boldness of Szechuan cooking. Every ingredient stands out, from the pickled greens and chili-vinegar soy sauce to the succulent noodles.",
            ingredients: """
            8 ounces Chinese wheat noodles, udon noodles, or soba noodles
            4 green onions, sliced
            ¼ cup pickled mustard greens or pickled cabbage\n1½ teaspoons soy sauce\n2 teaspoons rice vinegar
            1 teaspoon chili paste
            1 teaspoon toasted sesame seeds
""",
            directions: """
            1)Bring a medium pot of water to a boil. Add the noodles and cook them according to the directions, until they are slightly soft. Drain the water and set the noodles to the side.
            2)Over medium-high heat, add the green onion and pickled greens to a wok. Cook for about 1 minute. Remove them from the wok. Add the soy sauce, vinegar, chili paste, and noodles to the wok, and cook them for about 30 seconds.
            3)Plate each serving with half of the noodles, and garnish them with the cooked green onions, pickled greens, and sesame seeds.
""",
            category: "Main",
            datePublished: "2015-15-06",
            url: "https://www.forksoverknives.com/recipes/vegan-pasta-noodles/dan-dan-mian-noodles-recipe/"
        ),
        Recipe(
            name: "Mango and Black Bean Tacos",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/37358/mango_black_bean_tacos_01-1-e1488330832929-375x173-c.jpg",
            description: "The cornerstone of every Blue Zones diet in the world? Beans. There are at least 70 varieties of beans to choose from and an infinite number of ways to prepare them. Here’s one delicious recipe to spark your bean-spiration.",
            ingredients: """
            2 mangos, diced
            ½ red onion, diced
            1 red bell pepper, diced
            Juice of 1 lime
            Handful of cilantro, chopped
            2 avocados, diced
            1 (15-ounce) can black beans, drained and rinsed
            Salt to taste
            10 to 12 (6-inch) corn tortillas
            Mango salsa and/or choice of hot sauce
""",
            directions: """
            1)Place mango, red onion, red bell pepper, lime juice, chopped cilantro, avocado, black beans in a medium bowl. Mix well.
            2)Add a few generous pinches of salt. Taste and adjust seasoning. Chill until ready to use.
            3)Char (or warm) your tortillas. Place about ½ cup of the filling in the center of each tortilla. Fold and serve with salsa and/or hot sauce.
""",
            category: "Main",
            datePublished: "2017-28-03",
            url: "https://www.forksoverknives.com/recipes/vegan-burgers-wraps/mango-black-bean-tacos/"
        ),
        Recipe(
            name: "Sweet Moroccan Pancakes with Chocolate Banana Sauce",
            image: "https://www.forksoverknives.com/wp-content/uploads/fly-images/159544/Sweet-Moroccan-Pancakes-with-Chocolate-Banana-Sauce-wordpress-375x173-c.jpg?fresh",
            description: "These breakfast pancakes, called baghrir in Morocco, are similar to crepes, with a light, spongy texture. They’re traditionally topped with honey and butter, but are delicious with fresh fruit and a hearty drizzle of homemade chocolatey banana sauce. Spread the scrumptious batter very thin on your skillet to create the delicate mouthfeel these pancakes are known for. Feel free to enjoy them with a knife and fork, or roll up your toppings for a sweet taquito-style snack!",
            ingredients: """
            ½ teaspoon active dry yeast
            2 tablespoons + ½ teaspoon date paste
            2 bananas, peeled and cut into large pieces
            1½ cups unsweetened, unflavored almond milk
            ¾ cup whole wheat flour
            ¾ cup oat flour
            1 teaspoon regular or sodium-free baking powder
            ½ teaspoon sea salt
            ¼ cup + 1 tablespoon unsweetened cocoa powder
            ⅛ teaspoon pure vanilla extract
""",
            directions: """
            1)In a large bowl combine 1 cup warm water (105°F to 115°F), the yeast, and ½ teaspoon of the date paste. Cover bowl with a cloth; let stand about 10 minutes or until mixture is frothy.
            2)For Banana-Chocolate Sauce, in a blender combine bananas, ¾ cup almond milk, the remaining 2 tablespoons date paste, the cocoa powder, and vanilla extract. Cover and blend until smooth.
            3)In another bowl stir together whole wheat and oat flours, baking powder, and salt. Uncover yeast mixture; stir in the remaining ¾ cup almond milk and ½ cup water. Add flour mixture; whisk until smooth. Cover; let stand in a warm place 20 minutes.
            4)Preheat a nonstick skillet or crepe pan over medium-low about 3 minutes or until a drop of water dances when it hits the pan. Pour ⅓ cup of the batter in center of pan; use a crepe spreader or offset spatula to spread the batter into a 5-inch round. Cook 2 to 3 minutes or until underside is lightly browned. Use a thin spatula to turn pancake; cook 2 to 3 minutes more or until golden. Place pancake on a baking sheet; cover with a cloth. Keep warm in a 200°F oven while making remaining pancakes. Serve warm with a drizzle of Banana-Chocolate Sauce.
""",
            category: "Breakfast",
            datePublished: "2022-06-06",
            url: "https://www.forksoverknives.com/recipes/vegan-breakfast/sweet-moroccan-pancakes-chocolate-banana-sauce/"
        )
    ]
}
