//
//  Welcome.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 12.06.2025.
//

import Foundation
import OptionallyDecodable
// swiftlint:disable file_length
// MARK: - PhotoDTOElement
struct PhotoDTOElement: Codable {
    let id, slug: String
    let alternativeSlugs: AlternativeSlugs
    let createdAt, updatedAt: Date
    let promotedAt: JSONNull?
    let width, height: Int
    let color, blurHash: String
    let description: String?
    let altDescription: String
    let breadcrumbs: [JSONAny]
    let urls: Urls
    let links: PhotoDTOLinks
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [JSONAny]
    let sponsorship: JSONNull?
    let topicSubmissions: TopicSubmissions
    @OptionallyDecodable var assetType: AssetType?
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id, slug
        case alternativeSlugs = "alternative_slugs"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case altDescription = "alt_description"
        case breadcrumbs, urls, links, likes
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case sponsorship
        case topicSubmissions = "topic_submissions"
        case assetType = "asset_type"
        case user
    }
}

// MARK: PhotoDTOElement convenience initializers and mutators

extension PhotoDTOElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PhotoDTOElement.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: String? = nil,
        slug: String? = nil,
        alternativeSlugs: AlternativeSlugs? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        promotedAt: JSONNull?? = nil,
        width: Int? = nil,
        height: Int? = nil,
        color: String? = nil,
        blurHash: String? = nil,
        description: String?? = nil,
        altDescription: String? = nil,
        breadcrumbs: [JSONAny]? = nil,
        urls: Urls? = nil,
        links: PhotoDTOLinks? = nil,
        likes: Int? = nil,
        likedByUser: Bool? = nil,
        currentUserCollections: [JSONAny]? = nil,
        sponsorship: JSONNull?? = nil,
        topicSubmissions: TopicSubmissions? = nil,
        assetType: AssetType?? = nil,
        user: User? = nil
    ) -> PhotoDTOElement {
        return PhotoDTOElement(
            id: id ?? self.id,
            slug: slug ?? self.slug,
            alternativeSlugs: alternativeSlugs ?? self.alternativeSlugs,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            promotedAt: promotedAt ?? self.promotedAt,
            width: width ?? self.width,
            height: height ?? self.height,
            color: color ?? self.color,
            blurHash: blurHash ?? self.blurHash,
            description: description ?? self.description,
            altDescription: altDescription ?? self.altDescription,
            breadcrumbs: breadcrumbs ?? self.breadcrumbs,
            urls: urls ?? self.urls,
            links: links ?? self.links,
            likes: likes ?? self.likes,
            likedByUser: likedByUser ?? self.likedByUser,
            currentUserCollections: currentUserCollections ?? self.currentUserCollections,
            sponsorship: sponsorship ?? self.sponsorship,
            topicSubmissions: topicSubmissions ?? self.topicSubmissions,
            assetType: assetType ?? self.assetType,
            user: user ?? self.user
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - AlternativeSlugs
struct AlternativeSlugs: Codable {
    let en, es, ja, fr: String
    let it, ko, de, pt: String
}

// MARK: AlternativeSlugs convenience initializers and mutators

extension AlternativeSlugs {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AlternativeSlugs.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        en: String? = nil,
        es: String? = nil,
        ja: String? = nil,
        fr: String? = nil,
        it: String? = nil,
        ko: String? = nil,
        de: String? = nil,
        pt: String? = nil
    ) -> AlternativeSlugs {
        return AlternativeSlugs(
            en: en ?? self.en,
            es: es ?? self.es,
            ja: ja ?? self.ja,
            fr: fr ?? self.fr,
            it: it ?? self.it,
            ko: ko ?? self.ko,
            de: de ?? self.de,
            pt: pt ?? self.pt
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum AssetType: String, Codable {
    case photo
}

// MARK: - PhotoDTOLinks
struct PhotoDTOLinks: Codable {
    let linksSelf, html, download, downloadLocation: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: PhotoDTOLinks convenience initializers and mutators

extension PhotoDTOLinks {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PhotoDTOLinks.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        linksSelf: String? = nil,
        html: String? = nil,
        download: String? = nil,
        downloadLocation: String? = nil
    ) -> PhotoDTOLinks {
        return PhotoDTOLinks(
            linksSelf: linksSelf ?? self.linksSelf,
            html: html ?? self.html,
            download: download ?? self.download,
            downloadLocation: downloadLocation ?? self.downloadLocation
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - TopicSubmissions
struct TopicSubmissions: Codable {
    let streetPhotography, fashionBeauty, people: ArchitectureInterior?
    let film: Film?
    let architectureInterior, wallpapers, travel: ArchitectureInterior?
    let spirituality, nature: Film?
    let experimental, sports: ArchitectureInterior?
    
    enum CodingKeys: String, CodingKey {
        case streetPhotography = "street-photography"
        case fashionBeauty = "fashion-beauty"
        case people, film
        case architectureInterior = "architecture-interior"
        case wallpapers, travel, spirituality, nature, experimental, sports
    }
}

// MARK: TopicSubmissions convenience initializers and mutators

extension TopicSubmissions {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TopicSubmissions.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        streetPhotography: ArchitectureInterior?? = nil,
        fashionBeauty: ArchitectureInterior?? = nil,
        people: ArchitectureInterior?? = nil,
        film: Film?? = nil,
        architectureInterior: ArchitectureInterior?? = nil,
        wallpapers: ArchitectureInterior?? = nil,
        travel: ArchitectureInterior?? = nil,
        spirituality: Film?? = nil,
        nature: Film?? = nil,
        experimental: ArchitectureInterior?? = nil,
        sports: ArchitectureInterior?? = nil
    ) -> TopicSubmissions {
        return TopicSubmissions(
            streetPhotography: streetPhotography ?? self.streetPhotography,
            fashionBeauty: fashionBeauty ?? self.fashionBeauty,
            people: people ?? self.people,
            film: film ?? self.film,
            architectureInterior: architectureInterior ?? self.architectureInterior,
            wallpapers: wallpapers ?? self.wallpapers,
            travel: travel ?? self.travel,
            spirituality: spirituality ?? self.spirituality,
            nature: nature ?? self.nature,
            experimental: experimental ?? self.experimental,
            sports: sports ?? self.sports
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ArchitectureInterior
struct ArchitectureInterior: Codable {
    @OptionallyDecodable var status: Status?
    let approvedOn: Date?
    
    enum CodingKeys: String, CodingKey {
        case status
        case approvedOn = "approved_on"
    }
}

// MARK: ArchitectureInterior convenience initializers and mutators

extension ArchitectureInterior {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ArchitectureInterior.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        status: Status?? = nil,
        approvedOn: Date?? = nil
    ) -> ArchitectureInterior {
        return ArchitectureInterior(
            status: status ?? self.status,
            approvedOn: approvedOn ?? self.approvedOn
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Status: String, Codable {
    case approved
    case rejected
}

// MARK: - Film
struct Film: Codable {
    @OptionallyDecodable var status: Status?
}

// MARK: Film convenience initializers and mutators

extension Film {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Film.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        status: Status?? = nil
    ) -> Film {
        return Film(
            status: status ?? self.status
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

// MARK: Urls convenience initializers and mutators

extension Urls {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Urls.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        raw: String? = nil,
        full: String? = nil,
        regular: String? = nil,
        small: String? = nil,
        thumb: String? = nil,
        smallS3: String? = nil
    ) -> Urls {
        return Urls(
            raw: raw ?? self.raw,
            full: full ?? self.full,
            regular: regular ?? self.regular,
            small: small ?? self.small,
            thumb: thumb ?? self.thumb,
            smallS3: smallS3 ?? self.smallS3
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let updatedAt: Date
    let username, name, firstName: String
    let lastName, twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let links: UserLinks
    let profileImage: ProfileImage
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos, totalPromotedPhotos: Int
    let totalIllustrations, totalPromotedIllustrations: Int
    let acceptedTos, forHire: Bool
    let social: Social
    
    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalPromotedPhotos = "total_promoted_photos"
        case totalIllustrations = "total_illustrations"
        case totalPromotedIllustrations = "total_promoted_illustrations"
        case acceptedTos = "accepted_tos"
        case forHire = "for_hire"
        case social
    }
}

// MARK: User convenience initializers and mutators

extension User {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(User.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: String? = nil,
        updatedAt: Date? = nil,
        username: String? = nil,
        name: String? = nil,
        firstName: String? = nil,
        lastName: String?? = nil,
        twitterUsername: String?? = nil,
        portfolioURL: String?? = nil,
        bio: String?? = nil,
        location: String?? = nil,
        links: UserLinks? = nil,
        profileImage: ProfileImage? = nil,
        instagramUsername: String?? = nil,
        totalCollections: Int? = nil,
        totalLikes: Int? = nil,
        totalPhotos: Int? = nil,
        totalPromotedPhotos: Int? = nil,
        totalIllustrations: Int? = nil,
        totalPromotedIllustrations: Int? = nil,
        acceptedTos: Bool? = nil,
        forHire: Bool? = nil,
        social: Social? = nil
    ) -> User {
        return User(
            id: id ?? self.id,
            updatedAt: updatedAt ?? self.updatedAt,
            username: username ?? self.username,
            name: name ?? self.name,
            firstName: firstName ?? self.firstName,
            lastName: lastName ?? self.lastName,
            twitterUsername: twitterUsername ?? self.twitterUsername,
            portfolioURL: portfolioURL ?? self.portfolioURL,
            bio: bio ?? self.bio,
            location: location ?? self.location,
            links: links ?? self.links,
            profileImage: profileImage ?? self.profileImage,
            instagramUsername: instagramUsername ?? self.instagramUsername,
            totalCollections: totalCollections ?? self.totalCollections,
            totalLikes: totalLikes ?? self.totalLikes,
            totalPhotos: totalPhotos ?? self.totalPhotos,
            totalPromotedPhotos: totalPromotedPhotos ?? self.totalPromotedPhotos,
            totalIllustrations: totalIllustrations ?? self.totalIllustrations,
            totalPromotedIllustrations: totalPromotedIllustrations ?? self.totalPromotedIllustrations,
            acceptedTos: acceptedTos ?? self.acceptedTos,
            forHire: forHire ?? self.forHire,
            social: social ?? self.social
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String
    let portfolio: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio
    }
}

// MARK: UserLinks convenience initializers and mutators

extension UserLinks {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UserLinks.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        linksSelf: String? = nil,
        html: String? = nil,
        photos: String? = nil,
        likes: String? = nil,
        portfolio: String? = nil
    ) -> UserLinks {
        return UserLinks(
            linksSelf: linksSelf ?? self.linksSelf,
            html: html ?? self.html,
            photos: photos ?? self.photos,
            likes: likes ?? self.likes,
            portfolio: portfolio ?? self.portfolio
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String
}

// MARK: ProfileImage convenience initializers and mutators

extension ProfileImage {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProfileImage.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        small: String? = nil,
        medium: String? = nil,
        large: String? = nil
    ) -> ProfileImage {
        return ProfileImage(
            small: small ?? self.small,
            medium: medium ?? self.medium,
            large: large ?? self.large
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Social
struct Social: Codable {
    let instagramUsername: String?
    let portfolioURL: String?
    let twitterUsername: String?
    let paypalEmail: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolioURL = "portfolio_url"
        case twitterUsername = "twitter_username"
        case paypalEmail = "paypal_email"
    }
}

// MARK: Social convenience initializers and mutators

extension Social {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Social.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        instagramUsername: String?? = nil,
        portfolioURL: String?? = nil,
        twitterUsername: String?? = nil,
        paypalEmail: JSONNull?? = nil
    ) -> Social {
        return Social(
            instagramUsername: instagramUsername ?? self.instagramUsername,
            portfolioURL: portfolioURL ?? self.portfolioURL,
            twitterUsername: twitterUsername ?? self.twitterUsername,
            paypalEmail: paypalEmail ?? self.paypalEmail
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias PhotoDTO = [PhotoDTOElement]

extension Array where Element == PhotoDTO.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PhotoDTO.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(
                JSONNull.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Wrong type for JSONNull"
                )
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
