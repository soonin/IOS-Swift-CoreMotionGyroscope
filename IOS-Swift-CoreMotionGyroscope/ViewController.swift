//
//  ViewController.swift
//  IOS-Swift-CoreMotionGyroscope
//
//  Created by Pooya on 2018-09-12.
//  Copyright © 2018 Pooya. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var xGyro: UITextField!
    @IBOutlet weak var yGyro: UITextField!
    @IBOutlet weak var zGyro: UITextField!
    var motion = CMMotionManager()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        timer = Timer.scheduledTimer(timeInterval: 300.0, target: self, selector: #selector(ViewController.updateGyros), userInfo: nil, repeats: true)

        myGyroscope()
    }

    func myGyroscope(){
        print("Start Gyroscope \(timer)")
        motion.gyroUpdateInterval = 1
        motion.startGyroUpdates(to: OperationQueue.current!) {
            (data, error) in
            print(data as Any)
            if let trueData =  data {
                
                self.view.reloadInputViews()
                let x = trueData.rotationRate.x
                let y = trueData.rotationRate.y
                let z = trueData.rotationRate.z
                self.xGyro!.text = "x: \(Double(round(1000*x)/1000))"
                self.yGyro!.text = "y: \(Double(round(1000*y)/1000))"
                self.zGyro!.text = "z: \(Double(round(1000*z)/1000))"
            }
        }
        return
    }
    
    
    @objc func updateGyros() {
        print("Start Gyroscope")
        if motion.isGyroAvailable {
            print("Gyroscope is Available")
            self.motion.gyroUpdateInterval = 1.0 / 60.0
            self.motion.startGyroUpdates()
            
            // Configure a timer to fetch the accelerometer data.
            self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                               repeats: true, block: { (timer) in
                                // Get the gyro data.
                                if let data = self.motion.gyroData {
                                    let x = data.rotationRate.x
                                    let y = data.rotationRate.y
                                    let z = data.rotationRate.z
                                    print(data)

                                    self.xGyro!.text = "x: \(x)"
                                    self.yGyro!.text = "y: \(y)"
                                    self.zGyro!.text = "z: \(z)"
                                    // Use the gyroscope data in your app.
                                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer, forMode: .defaultRunLoopMode)
        }
    }
    
}

