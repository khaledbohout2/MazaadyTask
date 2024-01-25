
import Foundation

enum KnownErrors {

    enum ErrorCode: String {
        case decodingDataError = "ERROR-1"
        case invalidHTTPResponse = "ERROR-2"
        case invalidURL = "ERROR-3"
        case invalidRequest = "ERROR-4"
        case invalidData = "ERROR-5"
        case invalidResponse = "ERROR-6"
        case expiredToken = "ERROR-7"
        case unknown = "ERROR-0"
    }

    enum ErrorMessage: String {
        case decodingDataError = "Error decoding data"
        case invalidHTTPResponse = "Invalid HTTP response"
        case invalidURL = "Invalid URL"
        case invalidRequest = "Invalid request"
        case invalidData = "Invalid data"
        case invalidResponse = "Invalid response"
        case expiredToken = "Expired token"
        case unknown = "Unknown error"
    }

    static func getErrorMessage(errorCode: String) -> String {
        switch errorCode {
        case ErrorCode.decodingDataError.rawValue:
            return ErrorMessage.decodingDataError.rawValue
        case ErrorCode.invalidHTTPResponse.rawValue:
            return ErrorMessage.invalidHTTPResponse.rawValue
        case ErrorCode.invalidURL.rawValue:
            return ErrorMessage.invalidURL.rawValue
        case ErrorCode.invalidRequest.rawValue:
            return ErrorMessage.invalidRequest.rawValue
        case ErrorCode.invalidData.rawValue:
            return ErrorMessage.invalidData.rawValue
        case ErrorCode.invalidResponse.rawValue:
            return ErrorMessage.invalidResponse.rawValue
        case ErrorCode.expiredToken.rawValue:
            return ErrorMessage.expiredToken.rawValue
        default:
            return ErrorMessage.unknown.rawValue
        }
    }

}
