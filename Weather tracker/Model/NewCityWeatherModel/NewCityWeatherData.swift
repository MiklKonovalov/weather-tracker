//
//  NewCityWeatherData.swift
//  Weather tracker
//
//  Created by Misha on 13.02.2022.
//

import Foundation

// MARK: - NewCityData
struct NewCityData: Decodable {
    let response: Response
}

// MARK: - Response
struct Response: Decodable {
    let geoObjectCollection: GeoObjectCollection

    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
}

// MARK: - GeoObjectCollection
struct GeoObjectCollection: Decodable {
    let metaDataProperty: GeoObjectCollectionMetaDataProperty
    let featureMember: [FeatureMember]
}

// MARK: - FeatureMember
struct FeatureMember: Decodable {
    let geoObject: GeoObject

    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
}

// MARK: - GeoObject
struct GeoObject: Decodable {
    let metaDataProperty: GeoObjectMetaDataProperty
    let name, geoObjectDescription: String
    let boundedBy: BoundedBy?
    let point: Point

    enum CodingKeys: String, CodingKey {
        case metaDataProperty, name
        case geoObjectDescription = "description"
        case boundedBy
        case point = "Point"
    }
}

// MARK: - BoundedBy
struct BoundedBy: Decodable {
    let envelope: Envelope

    enum CodingKeys: String, CodingKey {
        case envelope = "Envelope"
    }
}

// MARK: - Envelope
struct Envelope: Decodable {
    let lowerCorner, upperCorner: String
}

// MARK: - GeoObjectMetaDataProperty
struct GeoObjectMetaDataProperty: Decodable {
    let geocoderMetaData: GeocoderMetaData

    enum CodingKeys: String, CodingKey {
        case geocoderMetaData = "GeocoderMetaData"
    }
}

// MARK: - GeocoderMetaData
struct GeocoderMetaData: Decodable {
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
struct Address: Decodable {
    let countryCode, formatted: String
    let components: [Component]

    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case formatted
        case components = "Components"
    }
}

// MARK: - Component
struct Component: Decodable {
    let kind, name: String
}

// MARK: - AddressDetails
struct AddressDetails: Decodable {
    let country: Country

    enum CodingKeys: String, CodingKey {
        case country = "Country"
    }
}

// MARK: - Country
struct Country: Decodable {
    let addressLine, countryNameCode, countryName: String
    let administrativeArea: AdministrativeArea?

    enum CodingKeys: String, CodingKey {
        case addressLine = "AddressLine"
        case countryNameCode = "CountryNameCode"
        case countryName = "CountryName"
        case administrativeArea = "AdministrativeArea"
    }
}

// MARK: - AdministrativeArea
struct AdministrativeArea: Decodable {
    let administrativeAreaName: String

    enum CodingKeys: String, CodingKey {
        case administrativeAreaName = "AdministrativeAreaName"
    }
}

// MARK: - Point
struct Point: Decodable {
    let pos: String
}

// MARK: - GeoObjectCollectionMetaDataProperty
struct GeoObjectCollectionMetaDataProperty: Decodable {
    let geocoderResponseMetaData: GeocoderResponseMetaData

    enum CodingKeys: String, CodingKey {
        case geocoderResponseMetaData = "GeocoderResponseMetaData"
    }
}

// MARK: - GeocoderResponseMetaData
struct GeocoderResponseMetaData: Decodable {
    let boundedBy: BoundedBy?
    let request, results, found: String
}

