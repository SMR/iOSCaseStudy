//
//  CSError.swift
//  iOSCaseStudy
//
//  Created by iSparsh on 21/02/21.
//

import Foundation

typealias CSErrorHandler = (CSError?) -> Void

struct CSError: Error {
    var localizedDescription: String
    init(_ localizedDescription: String) {
        self.localizedDescription = localizedDescription
    }
}

