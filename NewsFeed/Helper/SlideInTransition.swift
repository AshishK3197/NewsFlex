//
//  SlideInTransition.swift
//  NewsFeed
//
//  Created by Ashish Kumar on 09/08/20.
//  Copyright © 2020 Ashish Kumar. All rights reserved.
//

import UIKit

class SlideInTransition: NSObject,UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = false
    var isDimmingView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {return}
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting{
            //Add dimmingView
            isDimmingView.backgroundColor = .black
            isDimmingView.alpha = 0.0
            containerView.addSubview(isDimmingView)
            isDimmingView.frame = containerView.bounds
            //Add menuViewController to Container
            containerView.addSubview(toViewController.view)
            
            //Init from off the screen
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //Animate on screen
        let transform = {
            self.isDimmingView.alpha = 0.5
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        //Animate back off screen
        let identity = {
            self.isDimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        //Animate of the transition
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
    
    }
    

}
