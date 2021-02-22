//
//  RequestProtocol.swift
//  iOSCaseStudy
//
//  Created by iSparsh on 21/02/21.
//

import Foundation
public typealias HTTPHeaders = [String: String]

protocol RequestProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
    var headers: HTTPHeaders? { get }
}
