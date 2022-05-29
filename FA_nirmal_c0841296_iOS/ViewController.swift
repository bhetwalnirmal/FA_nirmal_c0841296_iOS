//
//  ViewController.swift
//  FA_nirmal_c0841296_iOS
//
//  Created by nirmal on 2022-05-26.
//

import UIKit

let ROW: Int = 3
let COLUMN: Int = 3

let NOUGHT: Int = 1
let CROSS: Int = 2
let EMPTY: Int = 0

class ViewController: UIViewController {
    @IBOutlet weak var btnPlayAgain: UIButton!
    // initialize the board variable
    var board: [[Mark]] = [[Mark]](repeating: [Mark](repeating: .EMPTY, count: ROW), count: COLUMN)
    
    var player1: Player = Player(name: "Player 1", mark: .NOUGHT)
    var player2: Player = Player(name: "Player 2", mark: .CROSS)
    var gameHistory: [GameHistory] = [GameHistory]()
    
    @IBOutlet weak var cell00: UIButton!
    @IBOutlet weak var cell01: UIButton!
    @IBOutlet weak var cell02: UIButton!
    @IBOutlet weak var cell10: UIButton!
    @IBOutlet weak var cell11: UIButton!
    @IBOutlet weak var cell12: UIButton!
    @IBOutlet weak var cell20: UIButton!
    @IBOutlet weak var cell21: UIButton!
    @IBOutlet weak var cell22: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // initialize the board
        initializeBoard()
        
    }
    
    // handle the touch event of the buttons
    @IBAction func onClickCell00(_ sender: UIButton) {
        var row = 0
        var column = 0
        
        // check which button was pressed
        switch sender {
            case cell00:
                row = 0
                column = 0
                break
            case cell01:
                row = 0
                column = 1
                break
            case cell02:
                row = 0
                column = 2
                break
            case cell10:
                row = 1
                column = 0
                break
            case cell11:
                row = 1
                column = 1
                break
            case cell12:
                row = 1
                column = 2
                break
            case cell20:
                row = 2
                column = 0
                break
            case cell21:
                row = 2
                column = 1
                break
            case cell22:
                row = 2
                column = 2
                break
            default:
                print("default")
                break
        }
        
        let mark = getCurrentPlayer().mark!
        
        board[row][column] = mark
        
        var imageName: String! = "nought"
        
        if mark == Mark.CROSS {
            imageName = "cross"
        }
        
        self.gameHistory.append(GameHistory(player: getCurrentPlayer(), mark: mark, row: row, column: column))
        
        sender.setImage(UIImage(named: imageName), for: .normal)
        if checkIfAUserWins() == true {
            print("user won")
        }
    }
    
    func initializeBoard () {
//        btnPlayAgain.isHidden = true
        for i in 0 ..< ROW {
            for j in 0 ..< COLUMN {
                board[i][j] = .EMPTY
            }
        }
    }
    
    func getCurrentPlayer () -> Player {
        let lastGame = self.gameHistory.last
        var player: Player? = nil
        
        if let game = lastGame {
            player = game.player
        }
        
        if player == nil {
            player = player1
        } else {
            if player == player1 {
                player = player2
            } else {
                player = player1
            }
        }
        
        return player!
    }
    
    func checkIfAUserWins () -> Bool {
        var hasWon = false
        
        for i in 0 ..< ROW {
            var isRowSame: Bool = false
            
            for j in 0 ..< COLUMN {
                if (board[i][j] == board[i][0] && board[i][0] != .EMPTY) || (board[j][i] == board[j][0] && board[j][0] != .EMPTY) {
                    if j == 2 {
                        isRowSame = true
                    }
                    continue
                } else {
                    isRowSame = false
                    break
                }
            }
            
            if isRowSame {
                hasWon = true
                break
            }
        }
        
        return hasWon
    }
}

