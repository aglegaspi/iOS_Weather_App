import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

class NetworkManager {
    
    // MARK: - Static Properties
    static let manager = NetworkManager()
    
    // MARK: - Internal Properties
    func performDataTask(withUrl url: URL,
                         andMethod httpMethod: HTTPMethod,
                         completionHandler: @escaping (Result<Data,AppError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        // TODO:
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                guard let data = data else {
                    completionHandler(.failure(.noDataReceived))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {
                    completionHandler(.failure(.badStatusCode))
                    return
                }
                
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        completionHandler(.failure(.noInternetConnection))
                        return
                    } else {
                        completionHandler(.failure(.other(rawError: error)))
                        return
                    }
                }
                // TODO:
                completionHandler(.success(data))
            }
        }.resume()
    }
    
    // MARK: - Private Properties and Initializers
    
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    private init() {}
}

