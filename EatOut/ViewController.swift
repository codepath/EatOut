//
//  ViewController.swift
//  Mindful Tips
//
//
//  TODO — Tether split
//  Select top countries and tip note


import UIKit


class ViewController: UIViewController {

    
    // bind ui elements
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var dinnerGuestsAmount: UISegmentedControl!
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var segmentBackground: UIView!
    @IBOutlet weak var humanIcon: UILabel!

    // set things up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial values
        tipLabel.text = "+ tip"
        totalLabel.text = "total"
        tipControl.alpha = 0
        dinnerGuestsAmount.alpha = 0
        tipLabel.alpha = 0
        totalLabel.alpha = 0
        segmentBackground.alpha = 0
        humanIcon.alpha = 0
        
        // register keyboard notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "kbShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "kbHidden:", name: UIKeyboardWillHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        bloat()
        billField.becomeFirstResponder()
    }
    
    
   
    
    
    // when keyboard shows
    func kbShown(notification: NSNotification) {
        UIView.animateWithDuration(0.4, animations: {
            self.tipControl.alpha = 1
            self.segmentBackground.alpha = 1
            self.tipLabel.alpha = 0.5
            self.totalLabel.alpha = 0.5
        })
    }
    
    
    // when keyboard hides
    func kbHidden(notification: NSNotification) {
        UIView.animateWithDuration(0.1, animations: {
            self.segmentBackground.alpha = 0
            self.tipControl.alpha = 0
        })
    }
    
    
    // handle rotation 
    // TODO: Add People Split 2 - 8
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            self.totalLabel.alpha = 1
            self.tipLabel.alpha = 0
            self.billField.alpha = 0
            self.dinnerGuestsAmount.alpha = 1
            self.humanIcon.alpha = 1
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            self.dinnerGuestsAmount.alpha = 0
            self.humanIcon.alpha = 0
        }
        
    }
    
    
    
    
    // stock func
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // listen to changes to input field and run calcs
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        var tipPercetanges = [0.15,0.20,0.25]
        var tipPercetange = tipPercetanges[tipControl.selectedSegmentIndex]
        
        var tipSplits = [1,2,3,4,5,6,7,8]
        var tipSplit =
            tipSplits[dinnerGuestsAmount.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text).doubleValue
        var tip = billAmount * tipPercetange
        var total = billAmount + tip
        // ideally --> var total = (billAmount + tip) / tipSplit
        
        tipLabel.text = String(format: "+ %.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
        
    }
    
    
    // listen for taps and hide keyboard
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func currencyTap(sender: AnyObject) {
        println("Shit")
    }
    
    
    func bloat() {
        var animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber(float: 0.975)
        animation.duration = 0.3
        animation.repeatCount = 6.0
        animation.autoreverses = true
        billField.layer.addAnimation(animation, forKey: nil)
    }
}


//    TRUNK
//
//    scaling animation
//
//    func bloat() {
//        var animation = CABasicAnimation(keyPath: "transform.scale")
//        animation.toValue = NSNumber(float: 1.5)
//        animation.duration = 0.2
//        animation.repeatCount = 4.0
//        animation.autoreverses = true
//        billField.layer.addAnimation(animation, forKey: nil)
//    }
    