//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by BKS-GGS on 30/08/21.
//

import XCTest
import SwiftUI

class CalculatorUITests: XCTestCase {
  
  func testSampleView() {
    
      let app = XCUIApplication()
      app.launch()
    
    
    let txtFieldLabel = app.textFields["SampleView.Hello.World.TextField.Label"].label
    let txtFieldValue = app.textFields["SampleView.Hello.World.TextField.Value"].value
    let txtFieldIdentifier = app.textFields["SampleView.Hello.World.TextField.Identifier"].identifier
    
    print(txtFieldLabel,txtFieldValue,txtFieldIdentifier)
    
//    usernameTextField.typeText("How are you")
//      usernameTextField.typeText("<username for app>")
    
//    let matching = app.textFields["SampleView.Hello.World.TextField"].exists
//    XCTAssertTrue(matching)
//    matching.keys = "How are you"
//    XCTAssertNotNil(
    
//    let matching = app.textFields["SampleView.Hello.World.TextField"].children(matching: .textField)
//    print(matching)
  }
//  
//  func testTextField() {
//
////    let matching = app.scrollViews["parent-scrollview"]
////    let matching = app.buttons["7 number"].firstMatch.identifier
//    
////    XCTAssertTrue(matching == "7 number", "7 number not found")
//    
////      .children(matching: .sta)
////      .descendants(matching: .button)
//    
////    let result =  matching.containing(.button, identifier: "7 number")
//    
////    let number7 = matching.containing(.button, identifier: "7 number")
//    
////    XCTAssertTrue(result.count > 0, "number7 is not found")
//    
////    XCTAssertTrue(matching.identifier == "output-textfield", "Not matched")
//    
//  }
  
  
}
