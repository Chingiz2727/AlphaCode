// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let placeModule = try? newJSONDecoder().decode(PlaceModule.self, from: jsonData)

import Foundation

// MARK: - PlaceModule
struct PlaceModule: Codable {
    let meta: Meta?
    let result: Results?
}

// MARK: - Meta
struct Meta: Codable {
    let apiVersion: String?
    let code: Int?
    let issueDate: String?
    
    enum CodingKeys: String, CodingKey {
        case apiVersion = "api_version"
        case code
        case issueDate = "issue_date"
    }
}

// MARK: - Result
struct Results: Codable {
    let items: [Item]?
    let total: Int?
}

// MARK: - Item
struct Item: Codable {
    let point: Point?
    
    let id, caption: String?
    
    
    enum CodingKeys: String, CodingKey {
        case point
        case id, caption
        
    }
}

// MARK: - Address
struct Address: Codable {
    let buildingID, buildingName: String?
    let components: [Component]?
    let postcode, buildingCode: String?
    
    enum CodingKeys: String, CodingKey {
        case buildingID = "building_id"
        case buildingName = "building_name"
        case components, postcode
        case buildingCode = "building_code"
    }
}

// MARK: - Component
struct Component: Codable {
    let number, street, streetID: String?
    let type: ComponentType?
    
    enum CodingKeys: String, CodingKey {
        case number, street
        case streetID = "street_id"
        case type
    }
}

enum ComponentType: String, Codable {
    case streetNumber = "street_number"
}

// MARK: - AdmDiv
struct AdmDiv: Codable {
    let name: String?
    let type: AdmDivType?
    let isDefault: Bool?
    let flags: Flags?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case name, type
        case isDefault = "is_default"
        case flags, id
    }
}

// MARK: - Flags
struct Flags: Codable {
    let isDefault: Bool?
    
    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
    }
}

enum AdmDivType: String, Codable {
    case city = "city"
    case district = "district"
    case districtArea = "district_area"
    case livingArea = "living_area"
    case region = "region"
    case settlement = "settlement"
}

// MARK: - Point
struct Point: Codable {
    let lat, lon: Double?
}

enum ItemType: String, Codable {
    case attraction = "attraction"
    case branch = "branch"
    case building = "building"
    case station = "station"
}
