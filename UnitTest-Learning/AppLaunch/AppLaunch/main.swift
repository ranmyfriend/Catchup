//
//  main.swift
//  AppLaunch
//
//  Created by Ranjit on 14/03/21.
//

import UIKit

/*
GOALS:
 1)How to bypass the Main AppDeleage running on Test suite.
 2)How to bypass the Scene Delegate running on Test suite.
 3)How to bypass the RootViewController running on Test suite.
 Objective:
 GOAL(1=>Covered here)ByPassing Main Appdelegate for running Test case.
 
This is how we can bypass the Main App delegate for running on Test Target. So, usually when you run any test suite the app delegate also will invoke first, then the respective test suite will run. but unnecesarly the main app delegate will invoke when you run any test case. So to avoid this funda, we have created our own app delegate class ie.TestingAppDelegate.swift
 */
let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
