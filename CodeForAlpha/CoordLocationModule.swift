
struct CoorLocation: Codable {
    let meta: Metas?
    let result: Resulti?
}

// MARK: - Meta
struct Metas: Codable {
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
struct Resulti: Codable {
    let items: [Itemi]?
    let total: Int?
}

// MARK: - Item
struct Itemi: Codable {
    let name, subtype, fullName, id: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case name, subtype
        case fullName = "full_name"
        case id, type
    }
}
