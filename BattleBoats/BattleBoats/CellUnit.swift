//
//  CellUnit.swift
//  battleBoat
//
//  Created by Noah Cordova on 2/22/21.
//

import UIKit

class CellUnit: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var cellSide: CGFloat = -100
    let col:Int
    let row:Int
    var color: UIColor
    let type: String
    
    enum celltype{
        case initialNone
        case Hit
        case HitShip
        case Miss
        case SafeShip
        case Empty
    }
    
    init(x: Int, y: Int, size: Int, color: UIColor, type: String) {
        col = x
        row = y
        self.color = color
        cellSide = CGFloat(size)
        self.type = type
        super.init(frame: CGRect(x: col, y: row, width: Int(cellSide), height: Int(cellSide)))
        
        initGestureRecognizers()
        run_func()
        
    }
    
    func run_func(){
        if(self.type == "alphnum"){
            
        }
        else{
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {

        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: cellSide, height: cellSide))
        color.setFill()
        path.fill()
        
        path.lineWidth = 2
        UIColor.black.setStroke()
        path.stroke()
    }
    func initGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: self.superview)
        print(tapPoint)
        print(self.center)
    }}
