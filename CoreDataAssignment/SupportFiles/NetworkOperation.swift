import UIKit
import ReachabilitySwift

// MARK: - Web Service Object Class

class NetworkOperation: NSObject {

let reachability = Reachability()

func postRequest(methodName: String, completion: @escaping (Any) -> Void) { 
    if !checkInternet() {
        return
    }
    guard let serviceUrl = URL(string: methodName) else { return }
    var request = URLRequest(url: serviceUrl)
    request.httpMethod = "POST"
    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: [:], options: []) else {
            return
        }
    request.httpBody = httpBody
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if response != nil {
        if let data = data {
                do {
                    _ = try JSONSerialization.jsonObject(with: data, options: [])
                    let responseString = String.init(data: data, encoding: String.Encoding.utf8)
                    completion(responseString as Any)
                } catch {
                    print("ERROR", error)
                }
            }
        }
        }.resume()
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
