//
//  HttpClient.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 17/06/24.
//

import Foundation

protocol HttpClient {
    func performRequest(request: URLRequest,
                        completion: @escaping (Result<(data: Data?, httpResponse: HTTPURLResponse), Error>) -> Void)
}

extension URLSession: HttpClient {
    struct InvalidURLRequestError: Error { }
    struct InvalidHttpResponseError: Error { }
    
    func performRequest(request: URLRequest,
                        completion: @escaping (Result<(data: Data?, httpResponse: HTTPURLResponse), Error>) -> Void) {
        dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(InvalidURLRequestError()))
                return
            }
            completion(.success((data, httpResponse)))
        }
        .resume()
    }
}
