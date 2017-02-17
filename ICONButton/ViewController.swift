//
//  ViewController.swift
//  ICONButton
//
//  Created by Alex Gibson on 2/16/17.
//  Copyright © 2017 AG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonDidTouchUpInside(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = UIColor.blue
        }, completion: {
            finsihed in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.view.backgroundColor = UIColor.white
            }, completion: nil)
        })
    }

}

