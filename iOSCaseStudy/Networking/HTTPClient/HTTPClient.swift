//
//  HTTPClient.swift
//  iOSCaseStudy
//
//  Created by iSparsh on 21/02/21.
//

import Foundation

class HTTPClient {
    // MARK: Typealias
    typealias CompletionResult = (Result<Data?, CSError>) -> Void
    
    // MARK: - Shared Instance
    static let shared = HTTPClient(session: URLSession.shared)
    
    // MARK: - Private Properties
    private let session: URLSessionProtocol
    private var task: URLSessionDataTaskProtocol?
    private var completionResult: CompletionResult?

    // MARK: - Initialiser
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK: - Data Task Helper
    func dataTask(_ request: RequestProtocol, completion: @escaping CompletionResult) {
        completionResult = completion
        var urlRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path),
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: Constants.Service.timeout)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.httpBody
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        task = session.dataTask(with: urlRequest) { (data, response, error) in
            //return error if there is any error in making request
            if let error = error {
                self.completionResult(.failure(CSError(error.localizedDescription)))
                return
            }
            
            //check response
            if let response = response, response.isSuccess {
                if let data = data {
                    self.completionResult(.success(data))
                }
                
                if response.httpStatusCode == 204 {
                    self.completionResult(.success(nil))
                }
            } else {
                let commonErrorMessage = NSLocalizedString("Somthing went wrong!", comment: "")
                guard let data = data else {
                    //Log.error(commonErrorMessage)
                    self.completionResult(.failure(CSError(commonErrorMessage)))
                    return
                }
                do {
                    let serverError = try JSONDecoder().decode(ServerError.self, from: data)
                   // Log.error(serverError.error ?? commonErrorMessage)
                    self.completionResult(.failure(CSError(serverError.error ?? commonErrorMessage)))
                } catch {
                    //Log.error(commonErrorMessage, error: error)
                    self.completionResult(.failure(CSError(commonErrorMessage)))
                }
            }
        }
        
        //Resume task
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    // MARK: - Private Helper Function
    private func completionResult(_ result: Result<Data?, CSError>) {
        DispatchQueue.main.async {
            self.completionResult?(result)
        }
    }
}
