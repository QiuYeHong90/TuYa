//
//  ViewController.swift
//  TuYaDemo
//
//  Created by ray on 2021/7/5.
//

import UIKit

struct ColorModel {
    var color:UIColor?
    
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var drawView: SHGraffitiView!
    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for item in self.stackView.arrangedSubviews {
            self.stackView.removeArrangedSubview(item)
        }
        
        let list:[UIColor] = [
            UIColor.black,
            UIColor.red,
            UIColor.gray,
            UIColor.yellow,
            UIColor.green,
            UIColor.blue,
            UIColor.brown,
        ]
//        UIButton
        for item in list {
            let itemB = UIButton.init(type: UIButton.ButtonType.custom)
            itemB.backgroundColor = item
            itemB.addTarget(self, action: #selector(self.tapClick(sender:)), for: UIControl.Event.touchUpInside)
            self.stackView.addArrangedSubview(itemB)
        }
        
        
    }
    @IBAction func cheXiaoCick(_ sender: Any) {
        self.drawView.revoke()
    }
    
    @objc func tapClick(sender:UIButton) {
        
        self.drawView.currentColor = sender.backgroundColor ?? .red
    }
}

