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
    // tic tac toe board image
    @IBOutlet weak var boardImage: UIImageView!
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
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // initialize the board
        initializeBoard()
        
        // initialize gesture recgonizer
        let swipeGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(resetGame))
        // add gesture recognizer to the view
        self.view.addGestureRecognizer(swipeGesture)
        
        self.becomeFirstResponder()
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
        
        // get the player's current mark
        let mark = getCurrentPlayer().mark!
        
        // set the cell of board to corresponding mark
        board[row][column] = mark
        
        var imageName: String! = "nought"
        
        // set the image to cross
        if mark == Mark.CROSS {
            imageName = "cross"
        }
        
        self.gameHistory.append(GameHistory(player: getCurrentPlayer(), mark: mark, row: row, column: column))
        
        // display cross or nought
        sender.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func initializeBoard (reset: Bool = false) {
//        btnPlayAgain.isHidden = true
        for i in 0 ..< ROW {
            for j in 0 ..< COLUMN {
                board[i][j] = .EMPTY
                
                if reset {
                    gameHistory = [GameHistory]()
                    
                    cell00.setImage(nil, for: .normal)
                    cell01.setImage(nil, for: .normal)
                    cell02.setImage(nil, for: .normal)
                    cell10.setImage(nil, for: .normal)
                    cell11.setImage(nil, for: .normal)
                    cell12.setImage(nil, for: .normal)
                    cell20.setImage(nil, for: .normal)
                    cell21.setImage(nil, for: .normal)
                    cell22.setImage(nil, for: .normal)
                }
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
        
        // check the diagonal of the board
        if (board[0][0] == board[1][1] && board[0][0] == board[2][2] && board[0][0] != .EMPTY) || (board[0][2] == board[1][1] && board[0][2] == board[2][0] && board[0][2] != .EMPTY) {
            hasWon = true
        }
        
        return hasWon
    }
    
    func reset () {
        initializeBoard(reset: true)
    }
    
    @objc func resetGame (_ sender: UISwipeGestureRecognizer) {
        reset()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        // handle logic on motion shake event
        if motion == .motionShake {
            
        }
    }
}

