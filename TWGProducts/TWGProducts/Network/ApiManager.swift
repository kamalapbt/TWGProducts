//
//  ApiManager.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 30/09/21.
//

import Foundation

enum ApiError: Error {
    case invalidRequest
    case unKnown
}

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "twg.azure-api.net"
        components.path = "/bolt/" + path
        components.queryItems = [URLQueryItem(
            name: "Branch",
            value: "<NEED-TO-PROVIDE-VALUE>"
        ),
        URLQueryItem(
            name: "UserID",
            value: "<NEED-TO-PROVIDE-VALUE>"
        ),
        URLQueryItem(
            name: "MachinID",
            value: "<NEED-TO-PROVIDE-VALUE>"
        )]+queryItems
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        
        return url
    }
}

extension Endpoint {
    static func search(for query: String) -> Self {
        Endpoint(
            path: "search.json",
            queryItems: [URLQueryItem(
                name: "Search",
                value: query
            )]
        )
    }
    
}
extension URLSession {
    @discardableResult
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        type: T.Type,
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) -> URLSessionDataTask {
        var request: URLRequest = URLRequest(url: endpoint.url)
        request.setValue("<NEED-TO-PROVIDE-VALID-KEY>", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        let task = dataTask(with: request) {data, _, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(ApiError.unKnown))
                return
            }
            do {
                let entities = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(entities))
            } catch {
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
        return task
    }
    
}
