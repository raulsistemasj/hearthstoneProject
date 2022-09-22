//
//  ApiServices.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 20/09/22.
//

import Foundation

public enum APIError: Error {
    case badURL, requestFailed(String), mappingError, unknown
}

public enum APISuccess {
    case success
}

public protocol APIServiceProtocol {
    func fetch<T: Codable>(model: T.Type, request: RequestProvider, completion: @escaping (Result<T, APIError>) -> Void)
    func fetch(request: RequestProvider, completion: @escaping (Result<APISuccess, APIError>) -> Void)
}

final public class APIService: APIServiceProtocol {
    
    // MARK: - Singleton
    
    public static let shared: APIServiceProtocol = APIService()

    // MARK: - Session
    
    let urlSession: URLSession

    // MARK: - Lifecycle
    
    private init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    // MARK: - Service Logic
    
    public func fetch<T>(model: T.Type, request: RequestProvider, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable, T : Encodable {
        guard let urlRequest = self.createURLRequest(request: request) else { completion(.failure(.badURL)); return }
        self.urlSession.dataTask(with: urlRequest) { data, response, error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data,
                  let response = try? decoder.decode(model, from: data) else { completion(.failure(.mappingError)); return }
            completion(.success(response))
        }.resume()
    }
    
    public func fetch(request: RequestProvider, completion: @escaping (Result<APISuccess, APIError>) -> Void) {
        guard let urlRequest = self.createURLRequest(request: request) else { completion(.failure(.badURL)); return }
        self.urlSession.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { completion(.failure(.requestFailed("[ERROR] \(error?.localizedDescription ?? "")"))); return }
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else { completion(.failure(.requestFailed("[ERROR] No success response"))); return }
            completion(.success(.success))
        }.resume()
    }
    
    private func createURLRequest(request: RequestProvider) -> URLRequest? {
            guard let url = URL(string: ApiConstants.baseURL + request.endpoint) else { return nil }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.httpMethod.value
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue(ApiConstants.key, forHTTPHeaderField: "X-RapidAPI-Key")
            urlRequest.setValue(ApiConstants.host, forHTTPHeaderField: "X-RapidAPI-Host")
            if !request.body.isEmpty {
                let httpBodyParameters = try? JSONSerialization.data(withJSONObject: request.body, options: [])
                urlRequest.httpBody = httpBodyParameters
            }
            return urlRequest
        }
}
