import UIKit
import Alamofire
import ReachabilitySwift

// MARK: - Web Service Object Class

class NetworkOperation: NSObject {

let reachability = Reachability()

func postRequest(methodName: String,
                 parameter: [String: Any],
                 completion: @escaping (Any) -> Void) {
        if !checkInternet() {
            return
        }
        let apiURl = methodName
        Alamofire.request(apiURl,
        method: HTTPMethod.get,
        parameters: parameter,
        encoding: URLEncoding.queryString,
        headers: nil).responseString(completionHandler: { (response) in
        switch response.result {
        case .success:
                completion(response.result.value!)
        case .failure:
                completion((response.result.error?.localizedDescription)!)
                }
        })
}

// MARK: - No Internet Alert Display

private func showAlert() {
    let alert = Alert()
    alert.msg(message: StringLiterals.ConnectionMessages.AlertTitle)
    alert.msg(
              message: StringLiterals.ConnectionMessages.AlertMsg,
              title: StringLiterals.ConnectionMessages.okStr)
}

// MARK: - Checking Internet

private func checkInternet() -> Bool {
        if reachability?.currentReachabilityStatus.description == StringLiterals.ConnectionMessages.AlertTitle {
            showAlert()
        } else {
            return true
        }
            return false
}

// MARK: Class Alert

private class Alert {

    func msg(message: String, title: String = StringLiterals.ConnectionMessages.AlertTitle) {
            let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: StringLiterals.ConnectionMessages.okStr,
            style: .default, handler: nil))
        UIApplication.shared.windows.filter {
        $0.isKeyWindow}.first?.rootViewController?.present(alertView, animated: true, completion: nil)
              }
        }
}
