//
//  TestErrors.swift
//  NetworkResponseTests
//
//  Created by BKS-GGS on 25/03/21.
//

import Foundation

struct TestError: LocalizedError {
    let message: String
    var errorDescription: String? {
        return message
    }
}
