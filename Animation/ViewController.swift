//
//  ViewController.swift
//  Animation
//
//  Created by qiyu on 2021/7/23.
//

import UIKit

class ViewController: UIViewController {
    
    var viewA: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewA = UIView(frame: CGRect(x: 0, y: 100, width: 40, height: 40))
        viewA.backgroundColor = .green
        view.addSubview(viewA)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
            let newFrame = self.viewA.frame.offsetBy(dx: 350, dy: 0)
            self.viewA.frame = newFrame
        }
    }


}

