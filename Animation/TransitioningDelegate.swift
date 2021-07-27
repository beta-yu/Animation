//
//  TransitioningDelegate.swift
//  TransitioningDelegate
//
//  Created by Yu Qi on 2021/7/27.
//

import UIKit

class TransitioningDelegate: NSObject {
    
    let animationController: AnimationController
    var gestureRecognizer: UIPanGestureRecognizer?
    
    override init() {
        self.animationController = AnimationController(animationDuration: 0.2, animationType: .present)
        super.init()
    }
    
}

extension TransitioningDelegate: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
                
        animationController.animationType = .present
        return animationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let vc = dismissed as? VCTViewControllerTwo {
            gestureRecognizer = vc.panGestureRecognizer
        }
        
        animationController.animationType = .dismiss
        return animationController
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let gr = gestureRecognizer else {
            return nil
        }
        return TransitionInteractionController(gestureRecognizer: gr)
    }
    
}

