//
//  main.swift
//  Spotify
//
//  Created by BKS-GGS on 26/03/21.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("TestAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
