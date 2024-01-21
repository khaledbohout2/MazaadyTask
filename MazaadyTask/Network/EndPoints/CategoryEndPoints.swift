
import Foundation

enum CategoryEndPoints: EndpointProvider {

    case getCategories
    case getProperties(subCat: Int)
    case getOptionsChild(optionId: Int)

    var path: String {
        switch self {
        case .getCategories:
            return "get_all_cats"
        case .getProperties(let subCat):
            return "properties?cat=\(subCat)"
        case .getOptionsChild(let optionId):
            return "get-options-child/\(optionId)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getCategories:
            return .get
        case .getProperties:
            return .get
            case .getOptionsChild:
            return .get
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }

    var body: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }

}
