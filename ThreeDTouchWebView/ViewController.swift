//
//  ViewController.swift
//  forceWebView
//
//  Created by Oscar Chiu on 26/09/2015.
//  Copyright © 2015 Oscar Chiu. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView?
    var lastForceValue: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        /* Now instantiate the web view */
        webView = WKWebView(frame: view.frame, configuration: configuration)
        
        if let theWebView = webView{
            let url = NSBundle.mainBundle().URLForResource("index", withExtension:"html")
            theWebView.loadFileURL(url!, allowingReadAccessToURL: url!)
            
            theWebView.scrollView.bounces = false
            
            theWebView.navigationDelegate = self
            view.addSubview(theWebView)
            print("Web View is loaded")
            
            if (traitCollection.forceTouchCapability == .Available) {
                print("3D Touch is available");
                let force = forceRecogniser(target: self, action: "didRecognizeForcePress:")
                
                view.addGestureRecognizer(force)
            }
            
        } else {
            EXIT_FAILURE
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRecognizeForcePress(forcePressRecognizer: forceRecogniser) {
        switch forcePressRecognizer.state {
        case .Changed:
            let percentageComplete = (forcePressRecognizer.averageRelativeForce);
            
            if (lastForceValue != percentageComplete) {
                
                lastForceValue = percentageComplete
                
                webView!.evaluateJavaScript("forceValue = \(percentageComplete)", completionHandler: nil)
            }
            
        default: break;
        }
    }
    
}
