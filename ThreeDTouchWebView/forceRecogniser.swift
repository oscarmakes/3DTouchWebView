//
//  forceRecogniser.swift
//  forceWebView
//
//  Created by Oscar Chiu on 26/09/2015.
//  Copyright © 2015 Oscar Chiu. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

@available(iOS 9.0, *)
@objc(forceWebView)
public class forceRecogniser: UIGestureRecognizer {
    
    /**
    Only allow the first finger to be the touch point
    */
    let numberOfTouchesRequired = 1
    
    /**
    While the state of the recognizer is Changed, contains the relative forces of the current touches.
    This value is otherwise nil.
    */
    public var relativeForces:[CGFloat]?
    
    /**
    The average relative force among all current touches, or 0 if the state of the recognizer is not Changed.
    */
    public var averageRelativeForce: CGFloat {
        if let forces = self.relativeForces {
            return forces.reduce(0, combine: +) / CGFloat(forces.count)
        }
        return 0
    }
    
    private var inProgress:Bool { return state == .Began || state == .Changed }
    private lazy var currentTouches = Set<UITouch>()
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        relativeForces = nil
        
        currentTouches.unionInPlace(touches)
        
        //We only start recognizing if *exactly* numberOfTouchesRequired of touches begin simultaneously
        if !inProgress &&
            currentTouches.count == touches.count &&
            currentTouches.count == numberOfTouchesRequired &&
            view?.traitCollection.forceTouchCapability == .Available {
                state = .Began
        } else if inProgress {
            currentTouches.removeAll()
        }
        
    }
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        
        if inProgress {
            relativeForces = touches.map({ $0.force / $0.maximumPossibleForce })
            
            let numberOfTouchesSuccessful = relativeForces!.filter({ $0 > 1 }).count
            
            if numberOfTouchesSuccessful == numberOfTouchesRequired {
                currentTouches.removeAll()
            } else {
                state = .Changed
            }
        }
        
    }
    
    public override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesCancelled(touches, withEvent: event)
        
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
    }
}