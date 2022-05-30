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
    var name: String!
    var mark: Mark!
    var winCount: Int
    var loseCount: Int
    
    // initialize the variables
    init(name: String!, mark: Mark!) {
        self.name = name
        self.mark = mark
        winCount = 0
        loseCount = 0
    }
    
    // function to increase the win count of the player
    func increaseWinCount () {
        self.winCount += 1
    }
    
    // function to increase the lose count of the player
    func increaseLoseCount () {
        self.loseCount += 1
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
}
