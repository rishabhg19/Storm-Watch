//
//  StormWatchViewController.swift
//  StormWatch
//
//  Created by Rishabh Ganesh on 8/19/21.
//

import UIKit

//extension to make background compatible with many devices
extension UIView
{
    // takes the background image name as a parameter
    func addBackground(backgroundName: String)
    {
        //set dimensions of the screen for ambiguous device
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height

        //set the background frame to appropriate dimensions, and reference background image
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        imageViewBackground.image = UIImage(named: backgroundName)

        // content mode can be changed
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill

        //make sure background does not overlap any other views
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }    
}

class StormWatchViewController: UIViewController
{
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var minsec: UILabel!
    @IBOutlet weak var centideciLabel: UILabel!
    @IBOutlet weak var dot: UILabel!
    @IBOutlet weak var switchButton: UIButton!
    
    override func viewDidLoad() {
        // initial setup
        super.viewDidLoad()
        self.view.addBackground(backgroundName: "mainback1")
        navigationItem.backButtonTitle = ""
        timer.invalidate()
        if totalsecs == 0.0
        {
            switchButton.isHidden = true
        }
        else
        {
            switchButton.isHidden = false
        }
        //valueLabel.isHidden = true
        resetButton.isEnabled = false
        startButton.isEnabled = true
        pauseButton.isEnabled = false
    }
    
    // initialize a timer, and important units for this app
    var timer = Timer()
    var isTimerRunning = false
    var minutes = 0
    var seconds = 0
    var centideci = 0
    var totalsecs = 0.0
    
    //segue to the other view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "switcher" {
               let destVC = segue.destination as! DistViewController
               destVC.statistic = totalsecs
          }
    }
    
    @IBAction func startDidTap(_ sender: Any) {
        switchButton.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self,selector: #selector(StormWatchViewController.runTimer), userInfo: nil, repeats: true)
        pauseButton.isEnabled = false
        if totalsecs > 0.0
        {
            pauseButton.isEnabled = true
        }
        resetButton.isEnabled = true
        if !isTimerRunning
        {
            isTimerRunning = true
            resetButton.isEnabled = true
            pauseButton.isEnabled = true
            startButton.isEnabled = false
        }
    }
    
    @IBAction func switchDidTap(_ sender: Any) {
        timer.invalidate()
        if totalsecs > 0
        {
            if !isTimerRunning
            {
                //isTimerRunning = false
                timer.invalidate()
                switchToDistVC()
                resetPressed()
            }
        }
        resetPressed()
    }
    @IBAction func pauseDidTap(_ sender: Any) {
        switchButton.isHidden = false
        resetButton.isEnabled = true
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        timer.invalidate()
    }
    
    @IBAction func resetDidTap(_ sender: Any) {
        timer.invalidate()
        resetButton.isEnabled = true
        switchButton.isHidden = true
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        resetPressed()
    }
    
    
    // define important behaviors of the reset button
    func resetPressed()
    {
        timer.invalidate()
        isTimerRunning = false
        
        minutes = 0
        seconds = 0
        centideci = 0
        minsec.text = "0  :  00"
        dot.text = "."
        centideciLabel.text = "00"
        resetButton.isEnabled = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        totalsecs = 0.0

    }
    
    // Helper methods
    // define how the timer runs and define the timer display
    @objc func runTimer()
    {
        centideci += 1
        if centideci > 99
        {
            seconds += 1
            centideci = 0
        }
        if seconds == 60
        {
            minutes+=1
            seconds = 0
        }
        let secString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        minsec.text = "\(minutes)  :   \(secString)"
        let centideciString = centideci > 9 ? "\(centideci)" : "0\(centideci)"
        centideciLabel.text = "\(centideciString)"
        totalsecs = Double(minutes*60 + seconds)
        totalsecs += Double(Double(centideci)/100.0)
        
    }
    
    //wrapper for segue
    func switchToDistVC() {
        performSegue(withIdentifier: "switcher", sender: AnyObject.self)
        //performSegue(sender: AnyObject.self)
    }
    
}
