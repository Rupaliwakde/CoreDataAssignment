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
               ANLoader.hide()
               if let newResponse = response as? Data {
               let jsonDecoder = JSONDecoder()
                do {
                  let data = try jsonDecoder.decode(DataList.self, from: newResponse)
                  self?.jsonListData = data
                  let currDictionary = try? DictionaryEncoder().encode(self?.jsonListData.current)
                  let minuteArray = try? DictionaryEncoder().encode(self?.jsonListData.minutely)
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
