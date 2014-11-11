//
//  PhotoViewController.swift
//  Wk4_Facebook
//
//  Created by Jaime Rovira on 11/10/14.
//  Copyright (c) 2014 Jaime Rovira. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    

    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var actionImageView: UIImageView!
    
    var image: UIImage!
    var isZooming: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        photoScrollView.delegate = self
        imageView.image = image
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView!)
    {
        isZooming = true
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat)
    {
        isZooming = false
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView)
    {
        UIView.animateWithDuration(0.4, animations:
            { () -> Void in
                self.doneButton.alpha = 0
                self.actionImageView.alpha = 0
        })
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView)
    {
        var scale = scrollView.zoomScale
        println(scrollView.contentOffset.y)
        
        if (!isZooming) && (scale < 1.3)
        {
            var distance = scrollView.contentOffset.y
            println(distance)
            
            if distance < 0
            {
                distance = 0 - distance
            }
            var alpha = (100 - distance)/100
            
            view.backgroundColor = UIColor(white: 0, alpha: alpha)
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        var scale = scrollView.zoomScale
        var distance = scrollView.contentOffset.y
        println(distance)
        
        UIView.animateWithDuration(0.4, animations:
            { () -> Void in
                self.doneButton.alpha = 1
                self.actionImageView.alpha = 1
        })
        
        println(scrollView.contentOffset.y)
        
        
        if (scale < 1.3) && ((distance > 100) || (distance < -100))
        {

            dismissViewControllerAnimated(true, completion: nil)
        }
        else if (!decelerate) && (scale < 1.3)
        {
            
            UIView.animateWithDuration(0.4, animations:
                { () -> Void in
                    self.view.backgroundColor = UIColor(white: 0, alpha: 1)
                    scrollView.zoomScale = 1
                    scrollView.contentOffset.y = 0
                    self.doneButton.alpha = 1
                    self.actionImageView.alpha = 1
            })
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView!
    {
        return imageView
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDoneButton(sender: AnyObject)  {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
