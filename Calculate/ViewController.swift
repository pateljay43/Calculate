//
//  ViewController.swift
//  Calculate
//
//  Created by JAY PATEL on 3/30/17.
//  Copyright © 2017 Jay Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var text: String = ""
    var regex: Regex!
    var eqGen: EquationGenerator!
    
    @IBAction func calculateCall(_ sender: UIButton) {
        text = textView.text!
        regex = Regex.init(text: text)
        regex.parse()
        eqGen = EquationGenerator(regex: regex)
        eqGen.generate()
        if(eqGen.evaluateEquation()){
            textView.text = eqGen.equation + " = " +  eqGen.result
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

