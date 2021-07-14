//
//  ViewController.swift
//  SwiftDemo
//
//  Created by DragonLi on 14/7/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        darkModeDemo()
    }

    fileprivate func darkModeDemo() {
        view.backgroundColor = UIColor.init(adpterWithHex: "PColor0")
    }
    
    

}

