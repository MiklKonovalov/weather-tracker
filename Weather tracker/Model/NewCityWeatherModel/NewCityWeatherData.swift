//
//  NewCityWeatherData.swift
//  Weather tracker
//
//  Created by Misha on 13.02.2022.
//

import Foundation

// MARK: - NewCityData
struct NewCityData: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let geoObjectCollection: GeoObjectCollection

    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
}

// MARK: - GeoObjectCollection
struct GeoObjectCollection: Codable {
    let metaDataProperty: GeoObjectCollectionMetaDataProperty
    let featureMember: [FeatureMember]
}

// MARK: - FeatureMember
struct FeatureMember: Codable {
    let geoObject: GeoObject

    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
}

// MARK: - GeoObject
struct GeoObject: Codable {
    let metaDataProperty: GeoObjectMetaDataProperty
    let name, geoObjectDescription: String
    let boundedBy: BoundedBy
    let point: Point

    enum CodingKeys: String, CodingKey {
        case metaDataProperty, name
        case geoObjectDescription = "description"
        case boundedBy
        case point = "Point"
    }
}

// MARK: - BoundedBy
struct BoundedBy: Codable {
    let envelope: Envelope

    enum CodingKeys: String, CodingKey {
        case envelope = "Envelope"
    }
}

// MARK: - Envelope
struct Envelope: Codable {
    let lowerCorner, upperCorner: String
}

// MARK: - GeoObjectMetaDataProperty
struct GeoObjectMetaDataProperty: Codable {
    let geocoderMetaData: GeocoderMetaData

    enum CodingKeys: String, CodingKey {
        case geocoderMetaData = "GeocoderMetaData"
    }
}

// MARK: - GeocoderMetaData
struct GeocoderMetaData: Codable {
    let precision, text, kind: String
    let address: Address
    let addressDetails: AddressDetails

    enum CodingKeys: String, CodingKey {
        case precision, text, kind
        case address = "Address"
        case addressDetails = "AddressDetails"
    }
}

// MARK: - Address
struct Address: Codable {
    let countryCode, formatted: String
    let components: [Component]

    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case formatted
        case components = "Components"
    }
}

// MARK: - Component
struct Component: Codable {
    let kind, name: String
}

// MARK: - AddressDetails
struct AddressDetails: Codable {
    let country: Country

    enum CodingKeys: String, CodingKey {
        case country = "Country"
    }
}

// MARK: - Country
struct Country: Codable {
    let addressLine, countryNameCode, countryName: String
    let administrativeArea: AdministrativeArea

    enum CodingKeys: String, CodingKey {
        case addressLine = "AddressLine"
        case countryNameCode = "CountryNameCode"
        case countryName = "CountryName"
        case administrativeArea = "AdministrativeArea"
    }
}

// MARK: - AdministrativeArea
struct AdministrativeArea: Codable {
    let administrativeAreaName: String

    enum CodingKeys: String, CodingKey {
        case administrativeAreaName = "AdministrativeAreaName"
    }
}

// MARK: - Point
struct Point: Codable {
    let pos: String
}

// MARK: - GeoObjectCollectionMetaDataProperty
struct GeoObjectCollectionMetaDataProperty: Codable {
    let geocoderResponseMetaData: GeocoderResponseMetaData

    enum CodingKeys: String, CodingKey {
        case geocoderResponseMetaData = "GeocoderResponseMetaData"
    }
}

// MARK: - GeocoderResponseMetaData
struct GeocoderResponseMetaData: Codable {
    let boundedBy: BoundedBy
    let request, results, found: String
}

typealias FeatureMemberCity = [FeatureMember]
