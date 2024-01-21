
import Foundation

enum RequestMethod: String {

    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

protocol EndpointProvider {

    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
}

extension EndpointProvider {

    var baseURL: String {
        return Constants.baseUrl
    }

    func asURLRequest() throws -> URLRequest {

        var urlComponents = URLComponents()
        urlComponents.path = baseURL + path
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        guard let url = URL(string: baseURL + path) else {
            throw ApiError(errorCode: "ERROR-0", message: "URL error")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")
        urlRequest.addValue("3%o8i}_;3D4bF]G5@22r2)Et1&mLJ4?$@+16", forHTTPHeaderField: "private-key")
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw ApiError(errorCode: "ERROR-0", message: "Error encoding http body")
            }
        }
        return urlRequest
    }

}
