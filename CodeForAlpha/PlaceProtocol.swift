//
//  PlaceProtocols.swift
//  YandexTaxiPlus
//
//  Created by Shyngys Kuandyk on 6/9/19.
//  Copyright © 2019 Чингиз. All rights reserved.
//

import Foundation
protocol makeOrder {
    func makeOrder(time:String,comment:String)
}
protocol firs_place_add {
    var first_place : Place_Module? {get set}
    func first_selected()
    func first_added()
}
protocol second_place_add {
    var second_place : Place_Module? {get set}
    func second_selected()
    func second_added()
}

protocol make_time_order {
    func make_time_order(hour:Double,time:String,comment:String)
}
