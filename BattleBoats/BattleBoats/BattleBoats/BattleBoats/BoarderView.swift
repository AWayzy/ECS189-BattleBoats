//
//  BoarderView.swift
//  battleBoat
//
//  Created by Noah Cordova on 2/21/21.
//

import UIKit

class BoarderView: UIScrollView {
    
    var cellSide: CGFloat = 41
    
    
    override func draw(_ rect: CGRect) {
        cellSide = bounds.width * 0.8 / 8
        isScrollEnabled = true
        contentSize = CGSize(width: frame.width+cellSide, height: frame.height+cellSide)
        drawBoard()
    }
    
    func drawBoard()  {
        let color = UIColor(red: 0, green: 94, blue: 184, alpha: 1.0)
        
        
        //let cell = CellUnit(x:0, y: 0 , size: Int(bounds.maxX), color: color)
        for row in stride(from: Int(bounds.minX), to: Int(bounds.height), by: Int.Stride(cellSide)) {
            for col in stride(from: Int(bounds.minY), to: Int(bounds.width), by: Int.Stride(cellSide)) {
               // drawSquare(col: col, row: row, color: color)
                let cellUnit = CellUnit(x: col, y: row , size: Int(cellSide), color: color, type: "none")
                
                //cell.addSubview(cellUnit)
                self.addSubview(cellUnit)
               
            }
           
            self.superview?.addSubview(self)
            
        }
       // print(self.subviews)
        //self.addSubview(cell)
        
    }
    func drawSquare(col: Int, row: Int, color: UIColor) {
        /* path = UIBezierPath(rect: CGRect(x: CGFloat(col), y: CGFloat(row), width: cellSide, height: cellSide))
        color.setFill()
        path.fill()
        
        path.lineWidth = 1
        UIColor.black.setStroke()
        path.stroke()*/
        
    }
}
