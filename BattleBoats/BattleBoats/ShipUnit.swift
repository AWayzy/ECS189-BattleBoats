//
//  ShipUnit.swift
//  BattleBoats
//
//  Created by Noah Cordova on 3/1/21.
//

import UIKit

class ShipUnit: CellUnit {

   
    let degreeRanges: [Double] = [-360, -270, -180, -90, 0 , 360, 270, 180, 90]
    var degree = 0.0
    var orientation = "V"
    
    override func initGestureRecognizers() {
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(self.didPan(panGR:)))
        self.addGestureRecognizer(panGR)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)

        let rotationGR = UIRotationGestureRecognizer(target: self, action: #selector(self.didRotate(rotationGR:)))
        self.addGestureRecognizer(rotationGR)

       
        
        isUserInteractionEnabled = true
        
    }

    @objc func didPan(panGR: UIPanGestureRecognizer) {

        
     
        if (panGR.state ==  UIGestureRecognizer.State.ended ) {
         
            // Magical moment: snaps ship into place, like on a real Battleship board.
            if (self.color == UIColor.yellow) {
                let snap = UIImpactFeedbackGenerator(style: .medium)
                snap.impactOccurred()
            }
            let boardView = superview?.viewWithTag(1)
            let outsideView = boardView?.superview
           
            let doneButton = outsideView?.viewWithTag(7) as? UIButton
            
            
            let newBounds:CGRect =  self.convert(self.bounds, to: boardView)
            let newBoundsX = newBounds.minX
            let newBoundsY = newBounds.minY
            if(newBoundsX > boardView?.bounds.minX ?? 0.0 && newBoundsY > boardView?.bounds.minY ?? 0.0 && newBounds.maxX < boardView?.bounds.maxX ?? 0.0 && newBounds.maxY < boardView?.bounds.maxY ?? 0.0){
                
                
                // prevent overlay start
                //let boardView = superview?.viewWithTag(1)
                let arr = boardView?.subviews[((boardView?.subviews.count ?? 0)  - 5) ... ((boardView?.subviews.count ?? 0) - 1)]
                
                let shipArr = arr?.filter{(view: UIView) in
                    if ((view as? CellUnit)?.type == "ship" && view != self){
                        return true
                    }
                    return false
                }
             
                var preventOverlay : Bool = false
                if (shipArr?.count != 0){
                    let arr_1 = shipArr?.map{ (view :UIView)  -> CGRect in
                        let test = view.convert(view.bounds , to: boardView)
                     
                        return test
                    }
                    let selfRangeX = newBoundsX ... newBounds.maxX
                    let selfRangeY = newBoundsY ... newBounds.maxY
                    
                    let overlayShipsArr = arr_1?.filter{(rect: CGRect) -> Bool in
                        let numberRangeX = rect.minX ... rect.maxX
                        let numberRangeY = rect.minY ... rect.maxY
                        
                        if ( numberRangeX.overlaps(selfRangeX) && numberRangeY.overlaps(selfRangeY)){
                            return true
                        }
                        return false
                      }
                  
                    if (overlayShipsArr?.count != 0){
                     
                       preventOverlay = true
                        if ( self.isDescendant(of: boardView ?? UIView())) {
                            self.removeFromSuperview()
                            outsideView?.addSubview(self)
                            self.color = UIColor.black
                            let newCenter = CGPoint(x: outsideView?.bounds.minX ?? 1.0, y: outsideView?.bounds.minY ?? 1.0)
                            let convertedPts = outsideView?.convert(newCenter, to: boardView)
                            self.color = UIColor.black
                       
                                self.center.x -= convertedPts?.x ?? 0.0
                                self.center.y -= convertedPts?.y ?? 0.0
                                                         
                           
                        } else {
                         
                            self.color = UIColor.black
                            self.setNeedsDisplay()
                        }
                        
                    }
                }
                //prevent overlay end
                
                
              
                if( !self.isDescendant(of: boardView ?? UIView()) && !preventOverlay ){
                    
                    self.removeFromSuperview()
                
                    let newCenter = CGPoint(x: boardView?.bounds.minX ?? 1.0, y: boardView?.bounds.minY ?? 1.0)
                   
                    let convertedPts = boardView?.convert(newCenter, to: outsideView)
                    
                    boardView?.addSubview(self)
                    
                    self.center.x -= convertedPts?.x ?? 0.0
                    self.center.y -= convertedPts?.y ?? 0.0
                    self.color = UIColor.yellow
                }
                
                if (!preventOverlay){
                boardView?.bringSubviewToFront(self)
                
                // Are there 5 ships placed properly on your grid? If so, you can move on.
                if ((boardView?.subviews.count ?? 0)  - 122 == 5) {
                        doneButton?.isEnabled = true
                }
                    
                let shipCenterX = self.center.x
                let shipCenterY = self.center.y
                let ran = self.cellSide
             
                let views = superview?.subviews.filter({ (view : UIView) -> Bool in
                    if (((shipCenterX-ran)...(shipCenterX+ran)) ~= view.center.x &&
                        ((shipCenterY-ran)...(shipCenterY+ran)) ~= view.center.y){
                        return true
                    }
                    return false
                })
              
                let view = views?.min(by: {(view1 : UIView, view2: UIView) -> Bool in
                 
                    if ( abs(view1.center.x - shipCenterX) < abs(view2.center.x - shipCenterX) && (view1 as? CellUnit)?.type == "cell" ){
                        return true
                    } else if ( abs(view1.center.x - shipCenterX) == abs(view2.center.x - shipCenterX) && (view1 as? CellUnit)?.type == "cell") {
                        if( abs(view1.center.y - shipCenterY) < abs(view2.center.y - shipCenterY) ){
                            return true
                        }
                        
                    }
                    return false
                })
              
                  
                    
                UIView.animate(withDuration: 0.25, animations: {
                    
                    let newCenter = view?.center ?? CGPoint(x: 0,y: 0)
                   
                    self.center = newCenter
            
                    
                    if (self.lengthY % 2 == 0){
                   
                        if (self.orientation == "H") {
                           // print("H")
                            self.center.x -= (self.cellSide/2)
                            
                        } else {
                        
                          
                                self.center.y -= (self.cellSide/2)
                                
                  
                                
                  
                        }
                       
                    }
                    self.setNeedsDisplay()
                    
                })
                
                }
                
             
            } else if (((newBoundsX < boardView?.bounds.minX ?? 0.0) || (newBoundsY < boardView?.bounds.minY ?? 0.0) || (newBounds.maxX > boardView?.bounds.maxX ?? 0.0) || (newBounds.maxY > boardView?.bounds.maxY ?? 0.0)) && (self.isDescendant(of: boardView ?? UIView())))
            {
              
                self.removeFromSuperview()
                
           
                let newCenter = CGPoint(x: outsideView?.bounds.minX ?? 1.0, y: outsideView?.bounds.minY ?? 1.0)
                let convertedPts = outsideView?.convert(newCenter, to: boardView)
                self.color = UIColor.black
                doneButton?.isEnabled = false
                self.center.x -= convertedPts?.x ?? 0.0
                self.center.y -= convertedPts?.y ?? 0.0
                 
                    
         
              
                outsideView?.addSubview(self)
              
            } else if (self.isDescendant(of: outsideView ?? UIView())) {
         
            }
            
            
            
        } else if (panGR.state == .changed ){
            
            self.superview!.bringSubviewToFront(self)
        
            let translation = panGR.translation(in: self.superview)
            
            self.center.x += translation.x
            self.center.y += translation.y

          
            
            
           
           
            panGR.setTranslation(CGPoint(x: 0,y: 0), in: self.superview)
            
           
        } else if (panGR.state == .began){
            
          
            if self.constraints.count  != 0 {
               
              
                self.removeAllConstraints()
            }
                
        }
        
        
    }
   
    @objc func didRotate(rotationGR: UIRotationGestureRecognizer) {

        self.superview!.bringSubviewToFront(self)
       
        let rotation = rotationGR.rotation
    
        
        
        if( rotationGR.state == .ended){
            
            // Magical moment: snaps ship into place, like on a real Battleship board.
            if (self.color == UIColor.yellow) {
                let snap = UIImpactFeedbackGenerator(style: .medium)
                snap.impactOccurred()
            }
        
           
            let rotate = rad2deg(self.degree).truncatingRemainder(dividingBy: 360)
            let rotationMin = degreeRanges.min{(num1, num2) -> Bool in
                if ( abs(num1 - rotate) < abs(num2 - rotate )) {
                    return true
                }
                return false
            } ?? 0.0
            let finalRot = deg2rad(rotationMin) - self.degree
            
          
            var changedOrt: Bool = false
            if ( abs(rotationMin) == 90){
                self.orientation = self.orientation ==  "H" ? "V" : "H"
                changedOrt = true
                
            }
            
            UIView.animate(withDuration: 1.0, animations: {
                
                self.transform = self.transform.rotated(by: CGFloat(finalRot))
                if (self.lengthY % 2 == 0){
                           
                    if (self.orientation == "H" && changedOrt) {
                      
                        self.center.x += (self.cellSide/2)
                        self.center.y -= (self.cellSide/2)
                    } else if ( self.orientation == "V" && changedOrt){
                        self.center.y -= (self.cellSide/2)
                        self.center.x -= (self.cellSide/2)
                        }
                                
                        }
                
            })
           
        
        } else if (rotationGR.state == .changed ){
            self.transform = self.transform.rotated(by: rotation)
            
         
            self.degree += Double(rotation)
            
        } else if ( rotationGR.state == .began){
            self.degree = 0.0
        }
       
        
        rotationGR.rotation = 0.0
        self.setNeedsDisplay()
        
    }
    
    func rad2deg(_ number: Double) -> Double {
        return number * 180 / .pi
    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    func removeAllConstraints() {
       
       var _superview = self.superview
               
               while let superview = _superview {
                   for constraint in superview.constraints {
                       
                       if let first = constraint.firstItem as? UIView, first == self {
                           superview.removeConstraint(constraint)
                       }
                       
                       if let second = constraint.secondItem as? UIView, second == self {
                           superview.removeConstraint(constraint)
                       }
                   }
                   
                   _superview = superview.superview
               }
               
               self.removeConstraints(self.constraints)
               self.translatesAutoresizingMaskIntoConstraints = true
       
   }
    
}
