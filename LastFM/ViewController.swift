//
//  ViewController.swift
//  LastFM
//
//  Created by Client1 on 09.11.15.
//  Copyright © 2015 Client1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var artistname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "sendSearch"){
            let vc = segue.destinationViewController as! ViewController2
            vc.test = artistname.text!
            
            
        }
    }
    
}

