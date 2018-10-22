//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Александр Макаров on 18.10.2018.
//  Copyright © 2018 Александр Макаров. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutdate : Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
}

extension RoomType {
    static func == (lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Rooms {
    static var content = Rooms()
    
    var rooms = [RoomType]()
    
    private init() {
        rooms.append(RoomType(id: 1, name: "Эконом", shortName: "Эконом", price: 30))
        rooms.append(RoomType(id: 2, name: "Стандартный", shortName: "Стандартный", price: 46))
        rooms.append(RoomType(id: 3, name: "Трехместный", shortName: "Трехместный", price: 44))
        rooms.append(RoomType(id: 4, name: "Полулюкс", shortName: "Полулюкс", price: 41))
        rooms.append(RoomType(id: 5, name: "Люкс однокомнатный", shortName: "Люкс однокомнатный", price: 46))
        rooms.append(RoomType(id: 6, name: "Люкс двухкомнатный", shortName: "Люкс двухкомнатный", price: 76))
    }
}
