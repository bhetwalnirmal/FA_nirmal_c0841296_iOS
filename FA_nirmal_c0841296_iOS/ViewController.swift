//
//  ViewController.swift
//  FA_nirmal_c0841296_iOS
//
//  Created by nirmal on 2022-05-26.
//

import UIKit

let ROW = 3
let COLUMN = 3

let NOUGHT: Int = 1
let CROSS: Int = 2
let EMPTY: Int? = nil

class ViewController: UIViewController {
    // initialize the board variable
    var board: [[Int?]] = [[Int?]](repeating: [Int?](repeating: EMPTY, count: ROW), count: COLUMN)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // initialize the board
        initializeBoard()
    }
    
    func initializeBoard () {
        for i in 0 ..< ROW {
            for j in 0 ..< COLUMN {
                print("\(i), \(j): \(board[i][j])")
            }
        }
    }
}

