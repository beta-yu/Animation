//
//  TransitionInteractionController.swift
//  TransitionInteractionController
//
//  Created by Yu Qi on 2021/7/27.
//

import UIKit

class TransitionInteractionController: UIPercentDrivenInteractiveTransition {

    let gestureRecognizer: UIPanGestureRecognizer
    
    init(gestureRecognizer: UIPanGestureRecognizer) {
        
        self.gestureRecognizer = gestureRecognizer
        super.init()
        
        self.gestureRecognizer.addTarget(self, action: #selector(gestureRecognizeDidUpdate(_:)))
    }
    
    func percentForGesture(_ gesture: UIPanGestureRecognizer) -> Double {
                
        let locationInContainerView = gesture.translation(in: nil)
        
        return locationInContainerView.y / gesture.view!.bounds.height
        
    }
    
    @objc func gestureRecognizeDidUpdate(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            break
        case .changed:
            update(percentForGesture(sender))
        case .ended:
            if percentForGesture(sender) > 0.3 {
                finish()
            } else {
                cancel()
            }
        default:
            cancel()
        }
        
    }
    
}
