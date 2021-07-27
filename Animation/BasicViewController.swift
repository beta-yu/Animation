//
//  BasicViewController.swift
//  BasicViewController
//
//  Created by Yu Qi on 2021/7/24.
//

import UIKit

class BasicViewController: UIViewController {

    var viewA: UIView!
    var button: UIButton!
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
//        viewA = UIView(frame: CGRect(x: 0, y: 100, width: 40, height: 40))
//        viewA.backgroundColor = .green
//        view.addSubview(viewA)
        
        button = UIButton(frame: CGRect(x: 100, y: 300, width: 50, height: 30))
        button.backgroundColor = .orange
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        
        containerView = UIView()
        containerView.frame = view.bounds
        view.addSubview(containerView)
        
    }
    
    @objc func buttonDidTap() {
        
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.0,
                       options: []) {
            self.button.bounds.size.width += 50
        }
        
        UIView.animate(withDuration: 0.33,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: []) {
            self.button.center.y += 50
            self.button.backgroundColor = .yellow
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
//            let newFrame = self.viewA.frame.offsetBy(dx: 350, dy: 0)
//            self.viewA.frame = newFrame
//        }
        
//        UIView.animate(withDuration: 1,
//                       delay: 0,
//                       usingSpringWithDamping: 0.7,
//                       initialSpringVelocity: 0,
//                       options: []) {
//            let newFrame = self.viewA.frame.offsetBy(dx: 200, dy: 0)
//            self.viewA.frame = newFrame
//        }
        

        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        newView.backgroundColor = .red
        newView.center = view.center
        
        UIView.transition(with: containerView,
                          duration: 3,
                          options: [.curveEaseOut, .transitionFlipFromBottom]) {
            self.containerView.addSubview(newView)
        }

    }
    
}
