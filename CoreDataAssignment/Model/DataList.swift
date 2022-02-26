import Foundation

struct JsonListData: Codable {

// MARK: - mapping the data fetched from current

var sunrise: Float?
var sunset: Float?
var temp: Float?
var pressure: Float?
var humidity: Float?
var uvi: Float?
var clouds: Float?
var visibility: Float?
    
// MARK: - coding keys enumeration

enum CodingKeys: String, CodingKey {
    case sunrise
    case sunset
    case temp
    case pressure
    case humidity
    case uvi
    case clouds
    case visibility
}

// MARK: - decoding values

init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    sunrise = try values.decode(Float?.self, forKey: .sunrise)
    sunset = try values.decode(Float?.self, forKey: .sunset)
    temp = try values.decode(Float?.self, forKey: .temp)
    pressure = try values.decode(Float?.self, forKey: .pressure)
    humidity = try values.decode(Float?.self, forKey: .humidity)
    uvi = try values.decode(Float?.self, forKey: .uvi)
    clouds = try values.decode(Float?.self, forKey: .clouds)
    visibility = try values.decode(Float?.self, forKey: .visibility)
 }
}

struct MinutelyData: Codable {

// MARK: - mapping the data fetched from minutely

var precipitation: Float?
    
// MARK: - coding keys enumeration

enum CodingKeys: String, CodingKey {
    case precipitation
}

// MARK: - decoding values

init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    precipitation = try values.decode(Float?.self, forKey: .precipitation)
 }
}

// MARK: - Modelling Struct

struct DataList: Codable {
    var current: JsonListData
    var minutely: [MinutelyData]
}
