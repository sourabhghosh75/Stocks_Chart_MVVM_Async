//
//  Webservice.swift
//  Stock Charts
//
//  Created by Sourabh Ghosh on 17/12/21.
//

import Foundation

enum NetworkError : Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod : String {
    case get = "GET"
    case post = "POST"
    
}
struct Resource <T:Codable> {
    
    let url : URL
    var httpmethod : HttpMethod = .get
    var body : Data? = nil
    let header : Dictionary<String,String> = [
        "x-rapidapi-host": "yh-finance.p.rapidapi.com",
        "x-rapidapi-key": "61100032f6msh11bd4abff63ac80p1f50abjsne7cf19306213"
    ]
}
class Webservice {
    
    func loadAsync<T>(resource: Resource<T>) async throws -> [Stock] {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpmethod.rawValue
        request.httpBody = resource.body
        request.allHTTPHeaderFields = resource.header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try? JSONDecoder().decode(QuoteResponse.self, from: data)
        
        if let response = response {
            let result = response.quoteResponse
            
            let stocks = result.result
            
            return stocks
            
        }
        else {
            return []
        }
        
    }
    
    func load<T>(resouce: Resource<T>, completion: @escaping (Result<[Stock] ,NetworkError>) -> Void) {
        
        var request = URLRequest(url: resouce.url)
        request.httpMethod = resouce.httpmethod.rawValue
        request.httpBody = resouce.body
        request.allHTTPHeaderFields = resouce.header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            let response = try? JSONDecoder().decode(QuoteResponse.self, from: data)
            
            if let response = response {
                let result = response.quoteResponse
                
                let stocks = result.result
                
                DispatchQueue.main.async {
                    completion(.success(stocks))
                }
                
                
                
            } else {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
                
            }
            
            
            
            
            
        }.resume()
    }
}
