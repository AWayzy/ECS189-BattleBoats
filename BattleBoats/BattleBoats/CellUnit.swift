//
//  CellUnit.swift
//  battleBoat
//
//  Created by Noah Cordova on 2/22/21.
//

import UIKit

class CellUnit: UIView{

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
    // var id: String
    let lenthW: Int
    let lengthY: Int
    enum celltype{
        case initialNone
        case Hit
        case HitShip
        case Miss
        case SafeShip
        case Empty
    }
    
    init(x: Int, y: Int, sizeX: Int, sizeY: Int, color: UIColor, type: String) {
        
        col = x
        row = y
        self.color = color
        cellSide = CGFloat(sizeX)
        lenthW = sizeX / Int(cellSide)
        lengthY = sizeY / Int(cellSide)
        
        self.type = type
        if (self.type == "ship"){
            let rect = CGRect(x: col, y: row, width: Int(cellSide), height: sizeY)
            super.init(frame: rect)
            
        } else {
            super.init(frame: CGRect(x: col, y: row, width: Int(cellSide), height: Int(cellSide)))
        }
        initGestureRecognizers()
      
        
    }
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        var path: UIBezierPath
        if (self.type == "ship"){
            path = UIBezierPath(roundedRect: rect, cornerRadius: 30)
        } else {
             path = UIBezierPath(rect: rect)
            
        }
            
      
        let desiredLineWidth:CGFloat = 10 // your desired value
        
     
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2
        layer.addSublayer(shapeLayer)
        
        if (self.type == "ship"){
            let shapeLayer = CAReplicatorLayer()
            
    
            
                
         
            let circle = CAShapeLayer()
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: (cellSide)/2, y: (cellSide/2)), radius: CGFloat( desiredLineWidth - (desiredLineWidth/2) ), startAngle: CGFloat(0), endAngle: CGFloat( Double.pi * 2), clockwise: true)
              
                
            circle.path = circlePath.cgPath
            circle.fillColor =  UIColor.red.cgColor
            circle.strokeColor = UIColor.black.cgColor
            circle.lineWidth = 2
           
            
            let instanceCount = self.lengthY
            
           
            shapeLayer.instanceCount = instanceCount
            shapeLayer.instanceTransform = CATransform3DMakeTranslation(0, cellSide, 0)
          
            
                
        
            shapeLayer.addSublayer(circle)
            layer.addSublayer(shapeLayer)
          
           
            
        }
      
           
    }
    
  
    func initGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let tapPoint = sender.location(in: self.superview)
      
        
      
        
        
        if (self.type == "ship"){
            
        }
       
    }
  
}
