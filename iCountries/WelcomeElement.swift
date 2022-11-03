// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseWelcomeElement { response in
//     if let welcomeElement = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let name: Name
    let tld: [String]?
    let cca2: String
    let ccn3: String?
    let cca3: String
    let cioc: String?
    let independent: Bool?
    let status: Status
    let unMember: Bool
    let currencies: [String:[String:String]]?
    let idd: Idd
    let capital: [String]?
    let altSpellings: [String]
    let region: Region
    let subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]
    let latlng: [Double]
    let landlocked: Bool
    let area: Double
    let demonyms: Demonyms?
    let flag: String
    let maps: Maps
    let population: Int
    let fifa: String?
    let car: Car
    let timezones: [String]
    let continents: [Continent]
    let flags, coatOfArms: CoatOfArms
    let startOfWeek: StartOfWeek
    let capitalInfo: CapitalInfo
    let postalCode: PostalCode?
    let borders: [String]?
    let gini: [String: Double]?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCapitalInfo { response in
//     if let capitalInfo = response.result.value {
//       ...
//     }
//   }

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCar { response in
//     if let car = response.result.value {
//       ...
//     }
//   }

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: Side
}

enum Side: String, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCoatOfArms { response in
//     if let coatOfArms = response.result.value {
//       ...
//     }
//   }

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCurrencies { response in
//     if let currencies = response.result.value {
//       ...
//     }
//   }

// MARK: - Currencies
struct Currencies: Codable {
    let bbd, usd, xaf, brl: Aed?
    let eur, aud, kid, ron: Aed?
    let lak, xof, iqd, kes: Aed?
    let kyd, gnf, tnd, bob: Aed?
    let cny, krw, kwd, dzd: Aed?
    let awg, rub, dkk, gbp: Aed?
    let twd, cad, fjd, xpf: Aed?
    let pen, clp, egp, mkd: Aed?
    let bdt, sgd, etb, bsd: Aed?
    let tmt, ang, zmw, hnl: Aed?
    let mad, npr, xcd, omr: Aed?
    let hkd, pyg, mdl, kgs: Aed?
    let mur, btn, inr, yer: Aed?
    let imp, dop, ggp, lrd: Aed?
    let zwl, ugx, vuv, ils: Aed?
    let jod, pkr, bnd, aed: Aed?
    let gel, scr, fkp, gip: Aed?
    let sbd, uzs, mnt, gyd: Aed?
    let bam: BAM?
    let top, rwf, bgn, ngn: Aed?
    let shp, fok, lsl, zar: Aed?
    let cve, kpw, cuc, cup: Aed?
    let srd, nzd, mxn, php: Aed?
    let sek, jmd, ves, jep: Aed?
    let afn, mop, syp, stn: Aed?
    let chf, szl, myr, pln: Aed?
    let ssp, khr, lkr, ghs: Aed?
    let ern, bzd, ttd, ckd: Aed?
    let mzn, irr, cdf, mvr: Aed?
    let mru, czk, byn, all: Aed?
    let mwk, sos, rsd, isk: Aed?
    let wst, mmk, thb, lbp: Aed?
    let kzt, tvd, huf, nok: Aed?
    let kmf: Aed?
    let sdg: BAM?
    let amd, uyu, sar, bif: Aed?
    let uah, sll, bmd, nad: Aed?
    let htg, lyd, pgk, aoa: Aed?
    let idr, ars, pab, jpy: Aed?
    let nio, tzs, tjs, gtq: Aed?
    let bhd, mga, djf, gmd: Aed?
    let bwp, currenciesTRY, azn, crc: Aed?
    let vnd, hrk, qar, cop: Aed?

    enum CodingKeys: String, CodingKey {
        case bbd = "BBD"
        case usd = "USD"
        case xaf = "XAF"
        case brl = "BRL"
        case eur = "EUR"
        case aud = "AUD"
        case kid = "KID"
        case ron = "RON"
        case lak = "LAK"
        case xof = "XOF"
        case iqd = "IQD"
        case kes = "KES"
        case kyd = "KYD"
        case gnf = "GNF"
        case tnd = "TND"
        case bob = "BOB"
        case cny = "CNY"
        case krw = "KRW"
        case kwd = "KWD"
        case dzd = "DZD"
        case awg = "AWG"
        case rub = "RUB"
        case dkk = "DKK"
        case gbp = "GBP"
        case twd = "TWD"
        case cad = "CAD"
        case fjd = "FJD"
        case xpf = "XPF"
        case pen = "PEN"
        case clp = "CLP"
        case egp = "EGP"
        case mkd = "MKD"
        case bdt = "BDT"
        case sgd = "SGD"
        case etb = "ETB"
        case bsd = "BSD"
        case tmt = "TMT"
        case ang = "ANG"
        case zmw = "ZMW"
        case hnl = "HNL"
        case mad = "MAD"
        case npr = "NPR"
        case xcd = "XCD"
        case omr = "OMR"
        case hkd = "HKD"
        case pyg = "PYG"
        case mdl = "MDL"
        case kgs = "KGS"
        case mur = "MUR"
        case btn = "BTN"
        case inr = "INR"
        case yer = "YER"
        case imp = "IMP"
        case dop = "DOP"
        case ggp = "GGP"
        case lrd = "LRD"
        case zwl = "ZWL"
        case ugx = "UGX"
        case vuv = "VUV"
        case ils = "ILS"
        case jod = "JOD"
        case pkr = "PKR"
        case bnd = "BND"
        case aed = "AED"
        case gel = "GEL"
        case scr = "SCR"
        case fkp = "FKP"
        case gip = "GIP"
        case sbd = "SBD"
        case uzs = "UZS"
        case mnt = "MNT"
        case gyd = "GYD"
        case bam = "BAM"
        case top = "TOP"
        case rwf = "RWF"
        case bgn = "BGN"
        case ngn = "NGN"
        case shp = "SHP"
        case fok = "FOK"
        case lsl = "LSL"
        case zar = "ZAR"
        case cve = "CVE"
        case kpw = "KPW"
        case cuc = "CUC"
        case cup = "CUP"
        case srd = "SRD"
        case nzd = "NZD"
        case mxn = "MXN"
        case php = "PHP"
        case sek = "SEK"
        case jmd = "JMD"
        case ves = "VES"
        case jep = "JEP"
        case afn = "AFN"
        case mop = "MOP"
        case syp = "SYP"
        case stn = "STN"
        case chf = "CHF"
        case szl = "SZL"
        case myr = "MYR"
        case pln = "PLN"
        case ssp = "SSP"
        case khr = "KHR"
        case lkr = "LKR"
        case ghs = "GHS"
        case ern = "ERN"
        case bzd = "BZD"
        case ttd = "TTD"
        case ckd = "CKD"
        case mzn = "MZN"
        case irr = "IRR"
        case cdf = "CDF"
        case mvr = "MVR"
        case mru = "MRU"
        case czk = "CZK"
        case byn = "BYN"
        case all = "ALL"
        case mwk = "MWK"
        case sos = "SOS"
        case rsd = "RSD"
        case isk = "ISK"
        case wst = "WST"
        case mmk = "MMK"
        case thb = "THB"
        case lbp = "LBP"
        case kzt = "KZT"
        case tvd = "TVD"
        case huf = "HUF"
        case nok = "NOK"
        case kmf = "KMF"
        case sdg = "SDG"
        case amd = "AMD"
        case uyu = "UYU"
        case sar = "SAR"
        case bif = "BIF"
        case uah = "UAH"
        case sll = "SLL"
        case bmd = "BMD"
        case nad = "NAD"
        case htg = "HTG"
        case lyd = "LYD"
        case pgk = "PGK"
        case aoa = "AOA"
        case idr = "IDR"
        case ars = "ARS"
        case pab = "PAB"
        case jpy = "JPY"
        case nio = "NIO"
        case tzs = "TZS"
        case tjs = "TJS"
        case gtq = "GTQ"
        case bhd = "BHD"
        case mga = "MGA"
        case djf = "DJF"
        case gmd = "GMD"
        case bwp = "BWP"
        case currenciesTRY = "TRY"
        case azn = "AZN"
        case crc = "CRC"
        case vnd = "VND"
        case hrk = "HRK"
        case qar = "QAR"
        case cop = "COP"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAed { response in
//     if let aed = response.result.value {
//       ...
//     }
//   }

// MARK: - Aed
struct Aed: Codable {
    let name, symbol: String
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseBAM { response in
//     if let bAM = response.result.value {
//       ...
//     }
//   }

// MARK: - BAM
struct BAM: Codable {
    let name: String
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDemonyms { response in
//     if let demonyms = response.result.value {
//       ...
//     }
//   }

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng: Eng
    let fra: Eng?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseEng { response in
//     if let eng = response.result.value {
//       ...
//     }
//   }

// MARK: - Eng
struct Eng: Codable {
    let f, m: String
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseIdd { response in
//     if let idd = response.result.value {
//       ...
//     }
//   }

// MARK: - Idd
struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseMaps { response in
//     if let maps = response.result.value {
//       ...
//     }
//   }

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseName { response in
//     if let name = response.result.value {
//       ...
//     }
//   }

// MARK: - Name
struct Name: Codable {
    let common, official: String
    let nativeName: [String: Translation]?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTranslation { response in
//     if let translation = response.result.value {
//       ...
//     }
//   }

// MARK: - Translation
struct Translation: Codable {
    let official, common: String
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responsePostalCode { response in
//     if let postalCode = response.result.value {
//       ...
//     }
//   }

// MARK: - PostalCode
struct PostalCode: Codable {
    let format: String
    let regex: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
    case monday = "monday"
    case saturday = "saturday"
    case sunday = "sunday"
}

enum Status: String, Codable {
    case officiallyAssigned = "officially-assigned"
    case userAssigned = "user-assigned"
}

typealias Welcome = [WelcomeElement]

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

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }

            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }

            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }

    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }

    @discardableResult
    func responseWelcome(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Welcome>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
