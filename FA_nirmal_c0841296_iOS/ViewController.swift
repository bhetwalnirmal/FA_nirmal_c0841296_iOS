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
    
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
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
    
    // set the view to become the first responder
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
        
        // set this view to first responder when user shakes the phone
        self.becomeFirstResponder()
    }
    
    // handle the touch event of the buttons
    @IBAction func onClickCell00(_ sender: UIButton) {
        var row = 0
        var column = 0
        let currentPlayer: Player = getCurrentPlayer()
        
        // get the player's current mark
        let mark = currentPlayer.mark!
        
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
        // disable the user interaction when the user clicks the cell
        sender.isUserInteractionEnabled = false
        
        var hasUserWon: Bool = checkIfAUserWins()
        
        if hasUserWon == true {
            // update the player's score when a player wins"
            currentPlayer.increaseWinCount()
            updatePlayerScoreBoard()
            
            // create the alert
            let alert = UIAlertController(title: "\(currentPlayer.name ?? "") won!", message: "\(currentPlayer.name ?? "") has won the game", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            let nextGameAction = UIAlertAction(title: "Play Again", style: .default) { (action) -> Void in
                self.reset()
            }
            
            alert.addAction(nextGameAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
        if isGameDraw() == true {
            // create the alert
            let alert = UIAlertController(title: "Draw", message: "Game is Draw", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            let nextGameAction = UIAlertAction(title: "Play Again", style: .default) { (action) -> Void in
                self.reset()
            }
            
            alert.addAction(nextGameAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func initializeBoard (reset: Bool = false) {
//        btnPlayAgain.isHidden = true
        for i in 0 ..< ROW {
            for j in 0 ..< COLUMN {
                board[i][j] = .EMPTY
                
                // reset the game
                if reset {
                    // set game history to empty
                    gameHistory = [GameHistory]()
                    
                    // empty the tic tac toe board and enable the user interaction
                    cell00.setImage(nil, for: .normal)
                    cell00.isUserInteractionEnabled = true
                    cell01.setImage(nil, for: .normal)
                    cell01.isUserInteractionEnabled = true
                    cell02.setImage(nil, for: .normal)
                    cell02.isUserInteractionEnabled = true
                    cell10.setImage(nil, for: .normal)
                    cell10.isUserInteractionEnabled = true
                    cell11.setImage(nil, for: .normal)
                    cell11.isUserInteractionEnabled = true
                    cell12.setImage(nil, for: .normal)
                    cell12.isUserInteractionEnabled = true
                    cell20.setImage(nil, for: .normal)
                    cell20.isUserInteractionEnabled = true
                    cell21.setImage(nil, for: .normal)
                    cell21.isUserInteractionEnabled = true
                    cell22.setImage(nil, for: .normal)
                    cell22.isUserInteractionEnabled = true
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
        
        if let lastMove = gameHistory.last {
            if (board[0][0] == board[0][1] && board[0][0] == board[0][2] && board[0][0] == lastMove.mark) {
                hasWon = true
            } else if (board[1][0] == board[1][1] && board[1][0] == board[1][2] && board[1][0] == lastMove.mark) {
                hasWon = true
            } else if (board[2][0] == board[2][1] && board[2][1] == board[2][2] && board[2][0] == lastMove.mark) {
                hasWon = true
            } else if (board[0][0] == board[1][0] && board[0][0] == board[2][0] && board[0][0] == lastMove.mark) {
                hasWon = true
            } else if (board[0][1] == board[1][1] && board[0][1] == board[2][1] && board[0][1] == lastMove.mark) {
                hasWon = true
            } else if (board[0][2] == board[1][2] && board[0][2] == board[2][2] && board[0][2] == lastMove.mark) {
                hasWon = true
                // check the diagonal of the board
            } else if (board[0][0] == board[1][1] && board[0][0] == board[2][2] && board[0][0] != .EMPTY) || (board[0][2] == board[1][1] && board[0][2] == board[2][0] && board[0][2] != .EMPTY) {
                hasWon = true
            }
        }
        
        return hasWon
    }
    
    func reset () {
        // re-initialize the board
        initializeBoard(reset: true)
    }
    
    @objc func resetGame (_ sender: UISwipeGestureRecognizer) {
        // reset the game
        reset()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        // handle logic on motion shake event
        if motion == .motionShake {
            if let lastMove = gameHistory.popLast() {
                undoLastMove(row: lastMove.row, column: lastMove.column)
            }
        }
    }
    
    func undoLastMove (row: Int, column: Int) {
        // check which button was pressed
        var pressedButton: UIButton? = nil
        
        // undo the last move of the user
        if row == 0 {
            if column == 0 {
                pressedButton = cell00
            } else if column == 1 {
                pressedButton = cell01
            } else if column == 2 {
                pressedButton = cell02
            }
        } else if row == 1 {
            if column == 0 {
                pressedButton = cell10
            } else if column == 1 {
                pressedButton = cell11
            } else if column == 2 {
                pressedButton = cell12
            }
        } else if row == 2 {
            if column == 0 {
                pressedButton = cell20
            } else if column == 1 {
                pressedButton = cell21
            } else if column == 2 {
                pressedButton = cell22
            }
        }
        
        // if the button is not nil then undo the move
        if let button = pressedButton {
            button.setImage(nil, for: .normal)
            // remove the last move from the array
            board[row][column] = Mark.EMPTY
        }
    }
    
    func updatePlayerScoreBoard () {
        player1Score.text = "Player 1 (\(getMark(mark: player1.mark))): \(player1.winCount)"
        player2Score.text = "Player 2 (\(getMark(mark: player2.mark))): \(player2.winCount)"
    }
    
    func getMark (mark: Mark) -> String {
        if mark == .CROSS {
            return "X"
        } else {
            return "O"
        }
    }
    
    func isGameDraw () -> Bool {
        var isBoardFilled = true
        
        for i in 0 ..< ROW {
            for j in 0 ..< COLUMN {
                if board[i][j] == .EMPTY {
                    isBoardFilled = false
                    
                    break
                }
            }
            
            if isBoardFilled == false {
                break
            }
        }
        
        return isBoardFilled
    }
}

