
import UIKit

extension UIFont {

    public enum PoppinsType: String {
        case regular = "-Regular"
    }

    static func poppins(_ type: PoppinsType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Poppins\(type.rawValue)", size: size)!
    }

}
