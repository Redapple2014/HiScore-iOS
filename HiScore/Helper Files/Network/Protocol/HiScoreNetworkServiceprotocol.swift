//
//  HiScoreNetworkServiceprotocol.swift
//  NetworkConnection
//
//  Created by RATPC-043 on 10/08/23.
//

import Foundation

protocol HiScoreNetworkServiceprotocol {
    func fetchData<T>(with request: URLRequest, model: T.Type, completion: @escaping (Result<T, APIError>) -> Void) where T: Decodable
    func postData<U>(with request: URLRequest, responseModelType: U.Type, completion: @escaping (Result<U, APIError>) -> Void) where U: Decodable
}

extension HiScoreNetworkServiceprotocol {
    func getData<T:Codable>(from url: URL,
                            model: T.Type,
                            completion: @escaping (Result<T, APIError>) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = HiScoreHTTPMethods.get.rawValue
        request.allHTTPHeaderFields = [:]
        fetchData(with: request, model: model, completion: completion)
    }
    func fetchData<T:Codable>(from endpoint: APIEndpoint,
                              model: T.Type,
                              completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HiScoreHTTPMethods.get.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        fetchData(with: request, model: model, completion: completion)
    }
    
    func postData<T:Encodable, U: Decodable>(to endpoint: APIEndpoint,
                                             with body: T? = nil,
                                             responseModelType: U.Type,
                                             completion: @escaping (Result<U, APIError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        do {
            let jsonData = try JSONEncoder().encode(body)
            var request = URLRequest(url: url)
            request.httpMethod = HiScoreHTTPMethods.post.rawValue
            request.allHTTPHeaderFields = endpoint.headers
            Log.d("API name: - \(url)")
            Log.d("Request Param: \(String(data: jsonData, encoding: .utf8))" )
            request.httpBody = jsonData
            postData(with: request, responseModelType: responseModelType, completion: completion)
        } catch {
            completion(.failure(.encodingError))
        }
    }
    func postData<U: Decodable>(to endpoint: APIEndpoint,
                                responseModelType: U.Type,
                                completion: @escaping (Result<U, APIError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HiScoreHTTPMethods.post.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        Log.d("API name: - \(url)")
        request.httpBody = nil
        postData(with: request, responseModelType: responseModelType, completion: completion)
    }
}

 class HiScoreNetworkRepository: HiScoreNetworkServiceprotocol {
     func postData<U>(with request: URLRequest, responseModelType: U.Type, completion: @escaping (Result<U, APIError>) -> Void) where U : Decodable {
        let session = URLSession.shared
        Log.d("API request url: \(String(describing: request.url))")
        Log.d("API request body: \(String(describing: request.httpBody))")
        Log.d("API request method: \(String(describing: request.httpMethod))")
        Log.d("API request header: \(String(describing: request.allHTTPHeaderFields))")
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error: error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.httpError(statusCode: httpResponse.statusCode)))
                return
            }
           
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            Log.d(String(data: data, encoding: .utf8))
            do {
                let decodedObject = try JSONDecoder().decode(responseModelType, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
        
    internal func fetchData<T>(with request: URLRequest, model: T.Type, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        
        let session = URLSession.shared
        Log.d("API request url: \(String(describing: request.url))")
        Log.d("API request body: \(String(describing: request.httpBody))")
        Log.d("API request method: \(String(describing: request.httpMethod))")
        Log.d("API request header: \(String(describing: request.allHTTPHeaderFields))")
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error: error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.httpError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            Log.d(String(data: data, encoding: .utf8))
            do {
                let decodedObject = try JSONDecoder().decode(model, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
