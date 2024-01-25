
import UIKit

extension UIFont {

    public enum PoppinsType: String {
        case regular = "-Regular"
        case bold = "-Bold"
        case semiBold = "-SemiBold"
        case medium = "-Medium"
    }

    static func poppins(_ type: PoppinsType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Poppins\(type.rawValue)", size: size)!
    }

}
