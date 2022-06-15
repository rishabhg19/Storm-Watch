//
//  DistViewController.swift
//  StormWatch
//
//  Created by Rishabh Ganesh on 5/21/22.
//

import Foundation
import UIKit

//keep images global for use in transition animation
var imageNames = ["back1", "back2", "back3", "back4", "back5", "back6", "back7","back8","back9","back10","back11","back12","back13", "back14","back15","back16","back17","back18","back19","back20","back21","back1","back13"]
var images = [UIImage]()

//extension for short animation after segue into this view controller
extension UIView
{
    func animateBackground()
    {
        // only populate UIImage array when it is initially empty
        if images.count == 0
        {
            for i in 0..<imageNames.count
            {
                images.append(UIImage(named: imageNames[i])!)
            }
        }
        //set the dimensions of the screen for ambiguous device
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height

        //set the background frame to appropriate dimensions, then animate
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        imageViewBackground.animationImages = images
        //imageViewBackground.image = UIImage(named: "back13")

        // animate and set background to particular image after
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        imageViewBackground.animationDuration = 1.5
        imageViewBackground.animationRepeatCount = 1
        imageViewBackground.startAnimating()
        imageViewBackground.image = images[images.count-1]
        self.addSubview(imageViewBackground)
        
        //make sure background is not overlapping other views
        self.sendSubviewToBack(imageViewBackground)
    }
}

class DistViewController : UIViewController
{
    // statistic receives data through segue, milestokm for conversion
    var statistic = Double()
    let milestokm = 1.60934
    
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var distBackground: UIImageView!
    @IBOutlet weak var obsLabel: UILabel!
    @IBOutlet weak var strikeLabel: UILabel!
    @IBOutlet weak var showLabel2: UILabel!
    @IBOutlet weak var timeElapsedLabel: UILabel!
    @IBOutlet weak var timeElapsedLabel2: UILabel!
    @IBOutlet weak var distLabel1: UILabel!
    @IBOutlet weak var distLabel2: UILabel!
    @IBOutlet weak var distLabelMI: UILabel!
    @IBOutlet weak var distLabelKM: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //animate to start, set initial states for other outlets
        self.view.animateBackground()
        prepareScreen()
        strikeLabel.isHidden = false
        obsLabel.isHidden = false
        showLabel.isHidden = false
        showLabel2.isHidden = false
        timeElapsedLabel.text = "Time elapsed between lightning"
        timeElapsedLabel2.text = "and thunder ~= \(statistic) seconds"
        distLabel1.text = "Approximate distance between"
        distLabel2.text = "observer and lightning strike is"
        distLabelMI.text = showLabel.text
        distLabelKM.text = showLabel2.text
        
    }
    
    //function that sets many of the initial states of the outlets
    func prepareScreen()
    {
        let miles = calculateMiles(timeElapsed: statistic)
        let km = convertMilesToKm(mi: miles)
        strikeLabel.text = "Lightning Strike"
        obsLabel.text = "Observer"
        showLabel.text = "\t\t\(miles) miles"
        showLabel2.text = "\t\t\(km) kilometers"
    }
    
    //calculations
    func calculateMiles(timeElapsed: Double)->Double
    {
        return round((timeElapsed/5.0)*100)/100.0
    }
    func convertMilesToKm(mi: Double)->Double
    {
        return round(mi*milestokm*100)/100.0
    }
    
    
}
