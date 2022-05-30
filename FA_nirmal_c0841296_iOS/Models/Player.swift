//
//  Player.swift
//  FA_nirmal_c0841296_iOS
//
//  Created by nirmal on 2022-05-27.
//

import Foundation

enum Mark: Int {
    case NOUGHT
    case CROSS
    case EMPTY
}

class Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String!
    var mark: Mark!
    
    init(name: String!, mark: Mark!) {
        self.name = name
        self.mark = mark
    }
}
