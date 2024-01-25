
import Foundation

protocol BaseCodable: Codable {
    var code: Int? { get set }
    var msg: String? { get set }
}

struct BaseModel: BaseCodable {
    var code: Int?
    var msg: String?
}

struct BaseModelWithData<T: Codable>: BaseCodable {
    var code: Int?
    var msg: String?
    var data: T?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try? container.decode(Int.self, forKey: .code)
        msg = try? container.decode(String.self, forKey: .msg)
        data = try? container.decode(T.self, forKey: .data)
    }
}
