//
//  ServerError.swift
//  iOSCaseStudy
//
//  Created by iSparsh on 21/02/21.
//

import Foundation
struct ServerError: Decodable {
    let status: String?
    let error: String?
}
