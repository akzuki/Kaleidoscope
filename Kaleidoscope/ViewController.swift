//
//  ViewController.swift
//  Kaleidoscope
//
//  Created by iosdev on 16.3.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawing: DrawView!
    @IBAction func clearTapped(sender: UIButton) {
        drawing.clear()
    }
    @IBAction func magicTapped(sender: UIButton) {
        drawing.flipVertically()
        drawing.rotation2(90)
        drawing.rotation2(45)
        drawing.rotation2(180)
        drawing.makeMagic()
        
    }
    @IBAction func flip(sender: UIButton) {
        drawing.flipVertically()
    }
    @IBAction func rotate90(sender: UIButton) {
        drawing.rotation2(90)
    }
    @IBAction func rotate45(sender: UIButton) {
        drawing.rotation2(45)
    }
    @IBAction func rotate180(sender: UIButton) {
        drawing.rotation2(180)
    }
    
    @IBAction func getImage(sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        drawing.layer.borderWidth = 1
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

