//
//  GameHistory.swift
//  FA_nirmal_c0841296_iOS
//
//  Created by nirmal on 2022-05-28.
//

import Foundation

class GameHistory {
    var player: Player
    var mark: Mark
    var row: Int
    var column: Int
    
    init(player: Player, mark: Mark, row: Int, column: Int) {
        self.player = player
        self.mark = mark
        self.row = row
        self.column = column
    }
}
