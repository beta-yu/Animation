//
//  TransitionController.swift
//  TransitionController
//
//  Created by qiyu on 2021/7/28.
//

import UIKit

class TransitionController: UIPercentDrivenInteractiveTransition {
    
    enum AnimationType {
        case present
        case dismiss
    }
    
    private let animationDuration: Double
    private var animationType = AnimationType.present
    private let backgroundView = UIView()
    var isInteractive = false
    
    init(animationDuration: Double) {
        self.animationDuration = animationDuration
        backgroundView.backgroundColor = .white
    }
    
}

extension TransitionController: UIViewControllerAnimatedTransitioning {
    
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
            self.isInteractive = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView) {
        
        viewToAnimate.frame.origin = CGPoint(x: 0, y: viewToAnimate.bounds.height)
        backgroundView.alpha = 0
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut) {
            viewToAnimate.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height - viewToAnimate.bounds.height)
            self.backgroundView.alpha = 1
        } completion: { _ in
            transitionContext.completeTransition(true)
        }

    }
    
}

extension TransitionController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
                
        animationType = .present
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        animationType = .dismiss
        return self
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        // You must not return an interaction controller from this method unless
        // the transition will be interactive.

        if isInteractive {
            return self
        }

        return nil
    }
    
}
