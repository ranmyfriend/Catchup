//
//  TestHelpers.swift
//  RefactoringTests
//
//  Created by BKS-GGS on 31/03/21.
//

import XCTest

func verfiyMethodCalledOnce(
    methodName: String,
    callCount: Int,
    describeArguments: @autoclosure () -> String,
    file: StaticString = #file,
    line: UInt = #line) -> Bool {
    if callCount == 0 {
        XCTFail("Wanted but not invoked:\(methodName)", file: file, line: line)
        return false
    }
    if callCount > 1 {
        XCTFail("Wanted 1 time but was called \(callCount) times." + "\(methodName) with \(describeArguments())", file: file, line: line)
        return false
    }
    return true
}

func verifyMethodNeverCalled(
    methodName: String,
    callCount: Int,
    describeArguments: @autoclosure () -> String,
    file: StaticString = #file,
    line: UInt = #line) {
    let times = callCount == 1 ? "time" : "times"
    if callCount > 0 {
        XCTFail("Never wanted but was called \(callCount) \(times)" + "\(methodName) with \(describeArguments())", file: file, line: line)
    }
}


func systemItem(for barButtonItem: UIBarButtonItem) -> UIBarButtonItem.SystemItem {
    let systemItemNumber = barButtonItem.value(forKey: "systemItem") as! Int
    return UIBarButtonItem.SystemItem(rawValue: systemItemNumber)!
}


func tap(_ button: UIBarButtonItem) {
    _ = button.target?.perform(button.action, with: nil)
}

func tap(_ button: UIButton) {
    button.sendActions(for: .touchUpInside)
}

func putInViewHierarchy(_ vc: UIViewController) {
    let window = UIWindow()
    window.addSubview(vc.view)
}

func executeRunLoop() {
    RunLoop.current.run(until: Date())
}
