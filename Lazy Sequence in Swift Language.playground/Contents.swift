import UIKit

//Lazy Sequence
//https://www.youtube.com/watch?v=gpEqDKudSmQ
/*
 What if you have long list and want to perform some operation on subset. like there are 500 elements in an array. but you want to apply multiply and additon in last 3 digits or 100..300 in a range. But here is the catch without looping over all of those elements we have to apply only particular subset. Using Lazy sequence we can able to achieve it.
 
 But when you have created a lazy sequence. unless otherwise if you iterate, then only the actions wil be performed on the subset.
 */

let indices = 1..<5000

let images = indices.lazy.filter { index -> Bool in
  print("filter")
  return index % 2 == 0
}.map { index -> String in
  print("map")
  return "image_\(index)"
}

let lastThreeImages = images.suffix(3)
for img in lastThreeImages {
  print(img)
}


