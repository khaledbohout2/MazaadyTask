
import Foundation

protocol ApiProtocol {
    func performRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T
}

final class ApiClient: ApiProtocol {

    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60 // seconds that a task will wait for data to arrive
        configuration.timeoutIntervalForResource = 300 // seconds for whole resource request to complete ,.
        return URLSession(configuration: configuration)
    }

    func performRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(for: endpoint.asURLRequest())
            print("response: \(response)")
            return try self.manageResponse(data: data, response: response)
        } catch let error as ApiError { // 3
            throw error
        } catch {
            throw ApiError(
                errorCode: "ERROR-0",
                message: "Unknown API error \(error.localizedDescription)"
            )
        }
    }

    private func manageResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw ApiError(
                errorCode: "ERROR-0",
                message: "Invalid HTTP response"
            )
        }
        switch response.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw ApiError(
                    errorCode: KnownErrors.ErrorMessage.decodingDataError.rawValue,
                    message: "Error decoding data"
                )
            }
        default:
            guard let decodedError = try? JSONDecoder().decode(ApiError.self, from: data) else {
                throw ApiError(statusCode: response.statusCode, errorCode: "ERROR-0", message: "Unknown backend error")
            }
            throw ApiError(
                statusCode: response.statusCode,
                errorCode: decodedError.errorCode,
                message: decodedError.message
            )
        }
    }

}

