import Foundation
import AVKit
import SwiftMessages
import ReachabilitySwift

// MARK: - Creating Constants:

enum StringLiterals {

    struct SwiftMsg {
      static let status = MessageView.viewFromNib(layout: .statusLine)
      static let statusConfig = SwiftMessages.defaultConfig
      static let success = MessageView.viewFromNib(layout: .cardView)
      static let successConfig = SwiftMessages.defaultConfig
    }
    struct Colors {
      static let ColorBg = UIColor.black
      static let ColorNavBar = UIColor.white
    }
    struct ConnectionMessages {
      static let AlertTitle = "Sorry,No Internet Connection!!"
      static let AlertMsg = "Make sure your device is connected to the internet"
      static let okStr = "Ok"
    }
   struct Insects {
      static let rightInset: CGFloat = -10.0
      static let leftInset: CGFloat = 10.0
      static let topInset: CGFloat = 30.0
      static let bottomInset: CGFloat = -30.0
      static let heightInset: CGFloat = 280.0
    }
    static let globalReachability = Reachability()
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    static let apiKey = "0003edd3279b2aee733e31b9c64dcb46"
    static let jsonUrl = "https://api.openweathermap.org/data/2.5/onecall?" +
                         "lat=33.441792&lon=-94.037689&exclude=hourly,daily&appid=\(apiKey)"
}
class DictionaryEncoder {
    private let jsonEncoder = JSONEncoder()
    // Encodes given Encodable value into an array or dictionary
    func encode<T>(_ value: T) throws -> Any where T: Encodable {
        let jsonData = try jsonEncoder.encode(value)
        return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    }
}

class DictionaryDecoder {
    private let jsonDecoder = JSONDecoder()
    // Decodes given Decodable type from given array or dictionary
    func decode<T>(_ type: T.Type, from json: Any) throws -> T where T: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        return try jsonDecoder.decode(type, from: jsonData)
    }
}
