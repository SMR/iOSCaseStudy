//
//  URLResponseExtension.swift
//  iOSCaseStudy
//
//  Created by iSparsh on 21/02/21.
//

import Foundation
extension URLResponse {
    var isSuccess: Bool {
        return httpStatusCode >= 200 && httpStatusCode < 300
    }
    
    var httpStatusCode: Int {
        guard let statusCode = (self as? HTTPURLResponse)?.statusCode else {
            return 0
        }
        return statusCode
    }
}

