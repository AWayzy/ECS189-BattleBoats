//
//  Ship.swift
//  BattleBoats
//
//  Created by Austin Way on 2/15/21.
//

import Foundation
import UIKit

class Ship: UIImageView{
    var name: String
    var length: Int
    var orientation: String
    var cellSide: CGFloat
    var height: CGFloat
    var width: CGFloat
    var x: CGFloat
    var y: CGFloat
    let originx: CGFloat
    let originy: CGFloat
    var cellIDsOnTopOf: [Int] = []
    var isInBounds: Bool = false
    var angleOfRotation: Double = 0.0
    var rotatedBy: Double = 0.0
    var rotationNumber = 1
    
    
    init(name: String, length: Int, orientation: String, x: CGFloat, y: CGFloat, cellSide: CGFloat){
        self.name = name
        self.length = length
        self.orientation = orientation
        self.cellSide = cellSide
        self.height = cellSide * CGFloat(length)
        self.width = cellSide
        self.x = x
        self.y = y
        self.originx = x
        self.originy = y
        super.init(frame: CGRect(x: x, y: y, width: cellSide, height: cellSide*CGFloat(length)))
        let rotationGR = UIRotationGestureRecognizer(target: self, action: #selector(self.didRotate(rotationGR:)))
        self.addGestureRecognizer(rotationGR)
        self.backgroundColor = UIColor.gray
        self.isUserInteractionEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotate90(){
        if self.orientation == "H"{
            self.orientation = "V"
            self.angleOfRotation = 0.0
        }
        else if self.orientation == "V"{
            self.orientation = "H"
            self.angleOfRotation = 90.0
        }
    }
    
    
    @objc func didRotate(rotationGR: UIRotationGestureRecognizer){
        let rotation = rotationGR.rotation
        
        if(rotationGR.state == .began){
            rotatedBy = 0.0
        }
        
        else if(rotationGR.state == .changed){
            self.transform = self.transform.rotated(by: rotation)
            rotatedBy += abs(rad2deg(rotation))
        }
        
        else if(rotationGR.state == .ended){
            if (self.backgroundColor == UIColor.gray) {
                let snap = UIImpactFeedbackGenerator(style: .medium)
                snap.impactOccurred()
            }
            rotatedBy = abs(rotatedBy)
            
            if rotatedBy < 45.0 || rotatedBy > 270.0{
                let rotationvar = (-1) * deg2rad(rotatedBy)
                self.transform = self.transform.rotated(by: rotationvar)
            }
            
            else if rotatedBy > 45.0 && rotatedBy < 135.0{
                let rotationvar = (-1) * deg2rad(rotatedBy)
                self.transform = self.transform.rotated(by: rotationvar)
                self.transform = self.transform.rotated(by: deg2rad(90.0))
                self.rotate90()
            }
            
            else if rotatedBy > 135.0 && rotatedBy < 215.0{
                let rotationvar = (-1) * deg2rad(rotatedBy)
                self.transform = self.transform.rotated(by: rotationvar)
            }
            
            else if rotatedBy > 215.0 && rotatedBy < 270.0{
                let rotationvar = (-1) * deg2rad(rotatedBy)
                self.transform = self.transform.rotated(by: rotationvar)
                self.transform = self.transform.rotated(by: deg2rad(90.0))
                self.rotate90()
            }
        }
        
        rotationGR.rotation = 0.0
        rotatedBy = 0.0
        self.setNeedsDisplay()
    }
            
        
    func rad2deg(_ number: CGFloat) -> Double {
        return Double(number * 180 / .pi)
        }
        
    func deg2rad(_ number: Double) -> CGFloat {
        return CGFloat(number * .pi / 180)
    }
    
    func setIsInBounds(isIn: Bool){
        self.isInBounds = isIn
    }

}
