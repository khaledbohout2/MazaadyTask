
import Foundation

protocol BaseCodable: Codable {
    var errorCode: String? { get set }
    var message: String? { get set }
}

struct BaseModel: BaseCodable {
    var errorCode: String?
    var message: String?
}
