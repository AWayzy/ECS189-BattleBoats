//
//  BoardViewController.swift
//  battleBoat
//
//  Created by Noah Cordova on 2/21/21.
//

import UIKit

class BoardViewController: UIViewController {

    let cellSide = 41
    
    @IBOutlet weak var boardView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let color = UIColor(red: 0, green: 94, blue: 184, alpha: 1.0)
     //  for row in stride(from: Int(boardView.bounds.minY), to: Int(boardView.bounds.height), by: Int.Stride(cellSide)) {
       //     for col in stride(from: Int(boardView.bounds.minX), to: Int(boardView.bounds.width), by: Int.Stride(cellSide))
          // {
        let col = self.boardView.frame.minX
        print(col)
        //print(self.view.bounds.width - boardView.bounds.width)
        self.view.addSubview(boardView)
        //print(self.view.subviews.first?.frame.minX)
        let row = boardView.frame.minY
       // let cell = CellUnit(x: Int(col), y: Int(row), size: 0, y: (row + (row/2))), color: color)
               // self.boardView.addSubview(cell)
                
          //  }
       // }
        
    }
    

    

}
