//
//  GameViewController.swift
//  BattleBoats
//
//  Created by Austin Way on 2/12/21.
//

import UIKit

class GameViewController: UIViewController {
    
    var theGame = Game()
    
    var cellArray: [CellUnit] = []
        
    @IBOutlet weak var boardView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let player1setBoard = theGame.player1.setBoard
        let player1shootBoard = theGame.player1.shootingBoard
        let player2setBoard = theGame.player2.setBoard
        let player2shootBoard = theGame.player2.shootingBoard
        
        
        let sides = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        let nums = [1,2,3,4,5,6,7,8,9,10]
        
        let cellSide = boardView.bounds.height / 11
        
        let color1 = UIColor(red: 0, green: 94, blue: 184, alpha: 1.0)

        
        for row in stride(from: 0, to: Int(boardView.bounds.height - cellSide), by: Int.Stride(cellSide)) {
            for col in stride(from: 0, to: Int(boardView.bounds.height - cellSide), by: Int.Stride(cellSide)){
                print(Float(row))
                print(Float(col))
                var bothelse = 0
                if(Float(row) == 0.0){
                    let txtField: UITextField = UITextField(frame: CGRect(x: CGFloat(col) + cellSide, y: CGFloat(row), width: cellSide, height: cellSide))
                    for i in 0...9{
                        if(col == Int(cellSide) * i){
                            txtField.text = sides[i]
                        }
                    }
                    txtField.textAlignment = .center
                    txtField.backgroundColor = UIColor.clear
                    txtField.isUserInteractionEnabled = false
                    self.boardView.addSubview(txtField)
                }
                else{
                    bothelse = bothelse + 1
                }
                if(Float(col) == 0.0){
                    let txtField: UITextField = UITextField(frame: CGRect(x: CGFloat(col), y: CGFloat(CGFloat(row) + cellSide), width: cellSide, height: cellSide))
                    for i in 0...9{
                        if(row == Int(cellSide) * i){
                            txtField.text = String(nums[i])
                        }
                    }
                    txtField.textAlignment = .center
                    txtField.backgroundColor = UIColor.clear
                    txtField.isUserInteractionEnabled = false
                    self.boardView.addSubview(txtField)
                }
                else{
                    bothelse = bothelse + 1
                }
                if bothelse == 2{
                    let cellUnit = CellUnit(x: col, y: row , size: Int(cellSide), color: color1, type: "cell")
                    self.boardView.addSubview(cellUnit)
                    self.cellArray.append(cellUnit)
                }
            }
        }
        
        //self.updateBoardView()
        //self.runGame()
        
        // Do any additional setup after loading the view.
    }
    
    func updateBoardView(){
        
        // write some sort of iteration here that will iteratively read the correct board and update the view controller accordingly. still doing research on how to properly detect screen sizes and everything, but this is likely how we will create most of the board
    
        return
    
    }
    
    func runGame(){
        return
    }


}

