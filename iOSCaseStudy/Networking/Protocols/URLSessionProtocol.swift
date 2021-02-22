//
//  URLSessionProtocol.swift
//  iOSCaseStudy
//
//  Created by iSparsh on 21/02/21.
//

import Foundation


protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}
