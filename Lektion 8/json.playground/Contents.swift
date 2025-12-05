

import Foundation


//Opgave 1.
let jsonText = """
{
"id": 1,
"currentDateTime": "2022-09-22T01:53:00Z",
"isDayLightSavingsTime": true,
"dayOfTheWeek": "Thursday",
"timeZoneName": "Eastern Standard Time",
"serviceResponse": null
}
"""

struct testData: Decodable{
    let id: Int
    let currentDateTime: Date
    let isDayLightSavingsTime: Bool
    let dayOfTheWeek: Weekdays
    let timeZoneName: String
    let serviceResponse: String?
    
    enum Weekdays: String, Codable{
        case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    }
}

let jsonData = Data(jsonText.utf8)
let jsonDecoder = JSONDecoder()
jsonDecoder.dateDecodingStrategy = .iso8601

do{
    let decodedTestData = try jsonDecoder.decode(testData.self, from: jsonData)
    print(decodedTestData.currentDateTime.description(with: Locale(identifier: "da_DK")))
}catch{
    print("Error: \(error.localizedDescription)")
}

//Opgave 2

let stationData = """
{
  "stations": [
    {
      "station_id": "2124036103510616644",
      "external_id": "2124036103510616644",
      "lon": -74.03121,
      "lat": 40.62994,
      "station_type": "classic",
      "capacity": 0,
      "electric_bike_surcharge_waiver": false,
      "rental_uris": {
        "android": "https://bkn.lft.to/lastmile_qr_scan",
        "ios": "https://bkn.lft.to/lastmile_qr_scan"
      },
      "has_kiosk": false,
      "region_id": "71",
      "name": "78 St & Ridge Blvd",
      "eightd_station_services": [],
      "rental_methods": [
        "KEY",
        "CREDITCARD"
      ],
      "eightd_has_key_dispenser": false,
      "short_name": "2625.01"
    }
  ]
}
"""

struct StationsResponse: Decodable {
    let stations: [Station]
}

struct Station: Decodable {
    let stationId: String
    let externalId: String
    let lon: Double
    let lat: Double
    let stationType: String
    let capacity: Int
    let electricBikeSurchargeWaiver: Bool
    let rentalUris: [String: URL]
    let hasKiosk: Bool
    let regionId: String
    let name: String
    let eightdStationServices: [String]?
    let rentalMethods: [RentalMethod]
    let eightdHasKeyDispenser: Bool
    let shortName: String

    enum RentalMethod: String, Decodable {
        case KEY
        case CREDITCARD
    }
}

let stationRawData = Data(stationData.utf8)
let jsonDecoderTwo = JSONDecoder()
jsonDecoderTwo.keyDecodingStrategy = .convertFromSnakeCase

do{
    let decodedStationData = try jsonDecoderTwo.decode(StationsResponse.self, from: stationRawData)
    print(decodedStationData.stations[0].stationId)
    print(decodedStationData.stations[0].rentalUris)
}catch{
    print("Error: \(error.localizedDescription)")
}



