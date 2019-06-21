//
//  SearchTgis.swift
//  YandexTaxiPlus
//
//  Created by Shyngys Kuandyk on 5/9/19.
//  Copyright © 2019 Чингиз. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Search {
    class func Search(query:String,completion:@escaping(_ result:PlaceModule)->()) {
        let urlString = "https://catalog.api.2gis.ru/2.0/suggest/endpoint/list?key=ruqbmh3282&page_size=100&region_id=67&q=\(query)"
        guard let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else { return }
        
        guard let url = URL.init(string: encodedUrl) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 5
        
        Alamofire.request(request).responseJSON { (response) in
            if let data = response.result.value {
                let json = JSON(data)
                print(json)
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let root = try decoder.decode(PlaceModule.self, from: response.data!)
                    completion(root)
                }
                catch let error {
                    print(error)
                }
                
            }
        }
        
    }
}


