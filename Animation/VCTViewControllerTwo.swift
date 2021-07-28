//
//  VCTViewControllerTwo.swift
//  VCTViewControllerTwo
//
//  Created by Yu Qi on 2021/7/24.
//

import UIKit

class VCTViewControllerTwo: UIViewController {

    @IBOutlet var yellowView: UIView!
    @IBOutlet var button: UIButton!
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(interactiveTransitionRecognizerAction(_:)))
        yellowView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func interactiveTransitionRecognizerAction(_ sender: UIPanGestureRecognizer) {
        
        guard let td = transitioningDelegate, let transitionController = td as? TransitionController else {
            return
        }
        
        let percent = percentForGesture(sender)
        switch sender.state {
        case .began:
            transitionController.isInteractive = true
            dismiss(animated: true, completion: nil)
        case .changed:
            transitionController.update(percent)
        case .ended:
            if percent > 0.2 {
                transitionController.finish()
            } else {
                transitionController.cancel()
            }
        default:
            transitionController.cancel()
        }
    
    }
    
    func percentForGesture(_ gesture: UIPanGestureRecognizer) -> Double {
                
        let translation = gesture.translation(in: nil)
        
        return translation.y / UIScreen.main.bounds.height
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
