
import Foundation

protocol BasePresenterProtocol: AnyObject {
    func viewDidLoad()
//    func handleRequestResponse<U: BaseCodable>(_ result: AFResult<U>,
//                                               inView view: BaseViewProtocol?,
//                                               withRouter router: BaseRouter?,
//                                               hideLoading: Bool?) -> U?
}

extension BasePresenterProtocol {

//    func handleRequestResponse<U: BaseCodable>(_ result: AFResult<U>,
//                                               inView view: BaseViewProtocol?,
//                                               withRouter router: BaseRouter?,
//                                               hideLoading: Bool? = true) -> U? {
//        if hideLoading == true { view?.stopLoading() }
//        switch result {
//        case .success(let data):
//            if data.errorCode == nil {
//                return data
//            } else if let errorCode = data.errorCode,
//                      let errorMessage = data.message {
//                if errorMessage == "Not Authorized" || errorCode == "NOT_AUTHORIZED" {
//                    view?.stopLoading()
//                    UserDefaultsService.sharedInstance.removeUserDefaults()
//                    router?.restartLoginScene()
//                } else if errorCode ==
//                            "AUTH_CODE_ALREADY_SEND" || errorMessage
//                            == "Please enter your verification code sent you earlier!" || errorCode ==
//                            "AUTH_CODE_INVALID" || errorMessage == "Invalid Code!" {
//                    return data
//                }
//                view?.showSelfDismissingErrorAlert(errorMessage)
//                return nil
//            } else {
//                view?.showSelfDismissingErrorAlert("Error")
//                return nil
//            }
//        case .failure(let error):
//            if error.localizedDescription != "Empty Response" {
//                view?.showSelfDismissingErrorAlert(error.localizedDescription)
//            }
//            return nil
//        }
//    }

}
