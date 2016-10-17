//
//  ViewController.swift
//  TestCameraRotation
//
//  Created by Warif Akhand Rishi on 8/7/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var noRotatingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noRotatingView = UIView.loadFromNibNamed("NoRotatingView")
        noRotatingView.frame = view.bounds
        view.addSubview(noRotatingView)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        noRotatingView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY);
        
        //Testing position
//        
//        let noRotationViewHeight = CGRectGetHeight(noRotatingView.bounds)
//        
//        var centerX = CGFloat(0)
//        var centerY = CGFloat(0)
//        
//        switch (UIDevice.currentDevice().orientation) {
//            
//        case .Portrait:
//            centerX = CGRectGetMidX(self.view.bounds)
//            centerY = CGRectGetHeight(self.view.bounds) - noRotationViewHeight / 2
//        case .PortraitUpsideDown:
//            centerX = CGRectGetMidX(self.view.bounds)
//            centerY = noRotationViewHeight / 2
//        case .LandscapeLeft:
//            centerX = CGRectGetWidth(self.view.bounds) - noRotationViewHeight / 2
//            centerY = CGRectGetMidY(self.view.bounds)
//        case .LandscapeRight:
//            centerX = noRotationViewHeight / 2
//            centerY = CGRectGetMidY(self.view.bounds)
//        default:
//            centerX = CGRectGetMidX(self.view.bounds)
//            centerY = CGRectGetMidY(self.view.bounds) - noRotationViewHeight
//        }
//        
//        noRotatingView.center = CGPointMake(centerX, centerY);
    }
    
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
//        
//        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
//            
//            let deltaTransform = coordinator.targetTransform()
//            let deltaAngle = atan2f(Float(deltaTransform.b), Float(deltaTransform.a))
//            
//            var currentRotation = self.noRotatingView.layer.valueForKeyPath("transform.rotation.z")?.floatValue
//            
//            // Adding a small value to the rotation angle forces the animation to occur in a the desired direction, preventing an issue where the view would appear to rotate 2PI radians during a rotation from LandscapeRight -> LandscapeLeft.
//            currentRotation = currentRotation! + (-1 * Float(deltaAngle)) + 0.0001
//            self.noRotatingView.layer.setValue(currentRotation, forKeyPath:"transform.rotation.z")
//            
//            }) { (UIViewControllerTransitionCoordinatorContext) -> Void in
//                
//                var currentTransform = self.noRotatingView.transform;
//                currentTransform.a = round(currentTransform.a);
//                currentTransform.b = round(currentTransform.b);
//                currentTransform.c = round(currentTransform.c);
//                currentTransform.d = round(currentTransform.d);
//                self.noRotatingView.transform = currentTransform;
//        }
//    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let targetRotation = coordinator.targetTransform
        let inverseRotation = targetRotation.inverted()
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            self.noRotatingView.transform = self.noRotatingView.transform.concatenating(inverseRotation)
            
            //self.noRotatingView.frame = self.view.bounds

            }) { (UIViewControllerTransitionCoordinatorContext) -> Void in
                
        }
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }

}

