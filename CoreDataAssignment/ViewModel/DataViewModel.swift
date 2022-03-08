import UIKit
import SwiftMessages
import ANLoader

class DataViewModel: NSObject {
// MARK: - Private Lets

private let coreManager = CoreDataManager()

// MARK: - For Binding ViewModel-ViewController

private(set) var jsonListData: DataList! {
    didSet {
    self.bindViewModelToController()
}}

var bindViewModelToController : (() -> Void) = {}

override init() {
    super.init()
    // Calling metgod to get data from url.
    callFuncToGetData()
}

// MARK: - Getting Data From Url

private func callFuncToGetData() {
    ANLoader.showLoading()
    NetworkOperation().postRequest(methodName: StringLiterals.jsonUrl) { [weak self] (response) in
              // print("response",response)
               ANLoader.hide()
               if let newResponse = response as? String {
               let jsonData = Data((newResponse).utf8)
               let jsonDecoder = JSONDecoder()
                do {
                  let data = try jsonDecoder.decode(DataList.self, from: jsonData)
                   // print("dataShow",data)
                  self?.jsonListData = data
                  let current = self?.jsonListData.current
                  let minutely = self?.jsonListData.minutely
                  let currDictionary = try? DictionaryEncoder().encode(current)
                  let minuteArray = try? DictionaryEncoder().encode(minutely)
                  self?.coreManager.setCurrentData(
                    current: (currDictionary as? NSDictionary)!,
                    minutely: (minuteArray as? NSArray)!)
                } catch {
                    debugPrint(error)
                }
          }
        }
    }
}
