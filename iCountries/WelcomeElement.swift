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
    let borders: [String]?
    let area: Double
    let demonyms: Demonyms?
    let flag: String
    let maps: Maps
    let population: Int
    let gini: [String: Double]?
    let fifa: String?
    let car: Car
    let timezones: [String]
    let continents: [Continent]
    let flags, coatOfArms: CoatOfArms
    let startOfWeek: StartOfWeek
    let capitalInfo: CapitalInfo
    let postalCode: PostalCode?
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
    let bgn, fkp, syp, byn: Aed?
    let inr, cuc, cup, eur: Aed?
    let mkd, tjs, btn, xaf: Aed?
    let sll, gbp, shp, uah: Aed?
    let ils, sos, nio, lkr: Aed?
    let usd, mdl, cad, aud: Aed?
    let xof, twd, tnd, pgk: Aed?
    let huf, dkk, xcd, xpf: Aed?
    let hnl, fok, gnf, ang: Aed?
    let kmf, hrk, cny, nzd: Aed?
    let lrd, hkd, iqd, bwp: Aed?
    let lyd, mnt, clp, zmw: Aed?
    let chf, kgs, tmt, mur: Aed?
    let php, bnd, sgd, kzt: Aed?
    let sar, mxn, thb, irr: Aed?
    let sbd, imp, wst, scr: Aed?
    let rsd, gyd, mvr, mzn: Aed?
    let awg, jep, sek, currenciesTRY: Aed?
    let gel, yer, dop, uzs: Aed?
    let kid, bbd, bmd, ugx: Aed?
    let kes, bsd, crc, nok: Aed?
    let vnd, kwd, mwk, bdt: Aed?
    let lbp, kpw, ckd, kyd: Aed?
    let rub, lak, tzs, ars: Aed?
    let sdg: BAM?
    let tvd, npr: Aed?
    let bam: BAM?
    let pln, pyg, nad, zar: Aed?
    let mru, szl, aed, cop: Aed?
    let cve, gip, all, pen: Aed?
    let ves, srd, jmd, dzd: Aed?
    let top, brl, bhd, zwl: Aed?
    let pkr, aoa, ngn, mop: Aed?
    let afn, ssp, krw, qar: Aed?
    let bzd, ttd, isk, rwf: Aed?
    let azn, gmd, bif, ern: Aed?
    let mad, ghs, ron, fjd: Aed?
    let idr, jod, uyu, omr: Aed?
    let bob, mga, vuv, lsl: Aed?
    let ggp, khr, etb, stn: Aed?
    let cdf, gtq, amd, jpy: Aed?
    let djf, egp, myr, htg: Aed?
    let czk, mmk, pab: Aed?

    enum CodingKeys: String, CodingKey {
        case bgn = "BGN"
        case fkp = "FKP"
        case syp = "SYP"
        case byn = "BYN"
        case inr = "INR"
        case cuc = "CUC"
        case cup = "CUP"
        case eur = "EUR"
        case mkd = "MKD"
        case tjs = "TJS"
        case btn = "BTN"
        case xaf = "XAF"
        case sll = "SLL"
        case gbp = "GBP"
        case shp = "SHP"
        case uah = "UAH"
        case ils = "ILS"
        case sos = "SOS"
        case nio = "NIO"
        case lkr = "LKR"
        case usd = "USD"
        case mdl = "MDL"
        case cad = "CAD"
        case aud = "AUD"
        case xof = "XOF"
        case twd = "TWD"
        case tnd = "TND"
        case pgk = "PGK"
        case huf = "HUF"
        case dkk = "DKK"
        case xcd = "XCD"
        case xpf = "XPF"
        case hnl = "HNL"
        case fok = "FOK"
        case gnf = "GNF"
        case ang = "ANG"
        case kmf = "KMF"
        case hrk = "HRK"
        case cny = "CNY"
        case nzd = "NZD"
        case lrd = "LRD"
        case hkd = "HKD"
        case iqd = "IQD"
        case bwp = "BWP"
        case lyd = "LYD"
        case mnt = "MNT"
        case clp = "CLP"
        case zmw = "ZMW"
        case chf = "CHF"
        case kgs = "KGS"
        case tmt = "TMT"
        case mur = "MUR"
        case php = "PHP"
        case bnd = "BND"
        case sgd = "SGD"
        case kzt = "KZT"
        case sar = "SAR"
        case mxn = "MXN"
        case thb = "THB"
        case irr = "IRR"
        case sbd = "SBD"
        case imp = "IMP"
        case wst = "WST"
        case scr = "SCR"
        case rsd = "RSD"
        case gyd = "GYD"
        case mvr = "MVR"
        case mzn = "MZN"
        case awg = "AWG"
        case jep = "JEP"
        case sek = "SEK"
        case currenciesTRY = "TRY"
        case gel = "GEL"
        case yer = "YER"
        case dop = "DOP"
        case uzs = "UZS"
        case kid = "KID"
        case bbd = "BBD"
        case bmd = "BMD"
        case ugx = "UGX"
        case kes = "KES"
        case bsd = "BSD"
        case crc = "CRC"
        case nok = "NOK"
        case vnd = "VND"
        case kwd = "KWD"
        case mwk = "MWK"
        case bdt = "BDT"
        case lbp = "LBP"
        case kpw = "KPW"
        case ckd = "CKD"
        case kyd = "KYD"
        case rub = "RUB"
        case lak = "LAK"
        case tzs = "TZS"
        case ars = "ARS"
        case sdg = "SDG"
        case tvd = "TVD"
        case npr = "NPR"
        case bam = "BAM"
        case pln = "PLN"
        case pyg = "PYG"
        case nad = "NAD"
        case zar = "ZAR"
        case mru = "MRU"
        case szl = "SZL"
        case aed = "AED"
        case cop = "COP"
        case cve = "CVE"
        case gip = "GIP"
        case all = "ALL"
        case pen = "PEN"
        case ves = "VES"
        case srd = "SRD"
        case jmd = "JMD"
        case dzd = "DZD"
        case top = "TOP"
        case brl = "BRL"
        case bhd = "BHD"
        case zwl = "ZWL"
        case pkr = "PKR"
        case aoa = "AOA"
        case ngn = "NGN"
        case mop = "MOP"
        case afn = "AFN"
        case ssp = "SSP"
        case krw = "KRW"
        case qar = "QAR"
        case bzd = "BZD"
        case ttd = "TTD"
        case isk = "ISK"
        case rwf = "RWF"
        case azn = "AZN"
        case gmd = "GMD"
        case bif = "BIF"
        case ern = "ERN"
        case mad = "MAD"
        case ghs = "GHS"
        case ron = "RON"
        case fjd = "FJD"
        case idr = "IDR"
        case jod = "JOD"
        case uyu = "UYU"
        case omr = "OMR"
        case bob = "BOB"
        case mga = "MGA"
        case vuv = "VUV"
        case lsl = "LSL"
        case ggp = "GGP"
        case khr = "KHR"
        case etb = "ETB"
        case stn = "STN"
        case cdf = "CDF"
        case gtq = "GTQ"
        case amd = "AMD"
        case jpy = "JPY"
        case djf = "DJF"
        case egp = "EGP"
        case myr = "MYR"
        case htg = "HTG"
        case czk = "CZK"
        case mmk = "MMK"
        case pab = "PAB"
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
