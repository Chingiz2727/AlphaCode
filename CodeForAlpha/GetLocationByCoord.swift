//
//  GetMyTLocation.swift
//  YandexTaxiPlus
//
//  Created by Shyngys Kuandyk on 6/6/19.
//  Copyright © 2019 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class getLocationByCoord {
    class func get(lat:Double,long:Double,completion:@escaping(_ place:CoorLocation)->()) {
        let url = "https://catalog.api.2gis.ru/2.0/geo/search"
        let params = ["key":"ruqbmh3282","point":"\(long),\(lat)","radius":"5","type":"building"]
        print(params)
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if let value = response.result.value {
                if let data = response.result.value {
                    let json = JSON(data)
                    print(json)
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let root = try decoder.decode(CoorLocation.self, from: response.data!)
                        completion(root)
                    }
                    catch let error {
                        print(error)
                    }
                    
                }            }
        }
    }
}
