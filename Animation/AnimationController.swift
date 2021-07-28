//
//  AnimationController.swift
//  AnimationController
//
//  Created by Yu Qi on 2021/7/24.
//

import UIKit

class AnimationController: NSObject {
    
    enum AnimationType {
        case present
        case dismiss
    }
    
    private let animationDuration: Double
    var animationType: AnimationType
    private let backgroundView = UIView()
    
    // MARK: Init
    
    init(animationDuration: Double, animationType: AnimationType) {
        self.animationDuration = animationDuration
        self.animationType = animationType
        backgroundView.backgroundColor = .white
    }
    
}

extension AnimationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
              let fromView = transitionContext.view(forKey: .from) else {
                  transitionContext.completeTransition(false)
                  return
              }
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(backgroundView, at: 0)
        backgroundView.frame = containerView.bounds
        
        switch animationType {
        case .present:
            containerView.addSubview(toView)
            presentAnimation(with: transitionContext, viewToAnimate: toView)
        case .dismiss:
            containerView.insertSubview(toView, belowSubview: fromView)
            dismissAnimation(with: transitionContext, viewToAnimate: fromView)
        }
    }
    
    func dismissAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView) {
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut) {
            viewToAnimate.frame.origin = CGPoint(x: 0, y: transitionContext.containerView.bounds.height)
            self.backgroundView.alpha = 0
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView) {
        
        viewToAnimate.frame.origin = CGPoint(x: 0, y: viewToAnimate.bounds.height)
        var size = viewToAnimate.bounds.size
        size.height = UIScreen.main.bounds.height - 50.0
        viewToAnimate.bounds.size = size
        backgroundView.alpha = 0
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut) {
            viewToAnimate.frame.origin = CGPoint(x: 0, y: 50.0)
            self.backgroundView.alpha = 1
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }
    
}
