//
//  VCTViewControllerTwo.swift
//  VCTViewControllerTwo
//
//  Created by Yu Qi on 2021/7/24.
//

import UIKit

class VCTViewControllerTwo: UIViewController {

    @IBOutlet var button: UIButton!
    var panGestureRecognizer: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(interactiveTransitionRecognizerAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func interactiveTransitionRecognizerAction(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    

    
}
