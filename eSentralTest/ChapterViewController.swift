//
//  ChapterViewController.swift
//  eSentralTest
//
//  Created by Daliso Ngoma on 24/07/2015.
//  Copyright © 2015 Daliso Ngoma. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChapterViewController: UIViewController, UIWebViewDelegate {
    
    var chapterURL = (UIApplication.sharedApplication().delegate as! AppDelegate).chapterURL
    var arrChapTitles = (UIApplication.sharedApplication().delegate as! AppDelegate).arrChapTitles
    var chapterPos = (UIApplication.sharedApplication().delegate as! AppDelegate).chapterPos
    
    var url:NSURL?
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBAction func backButton(sender: AnyObject) {
        
        if(chapterPos > 0) {
            chapterPos--
            url = NSBundle.mainBundle().URLForResource("assets/\(arrChapTitles[chapterPos])", withExtension:"html")
            if url != nil {
                let urlRequest = NSURLRequest(URL: url!)
                webView.loadRequest(urlRequest)
            } else {
                print("There seems to be an error")
            }
        } else {
            print("Already at beginning")
        }
    }
    
    @IBAction func forwardButton(sender: AnyObject) {
        if(chapterPos < arrChapTitles.count-1) {
            chapterPos++
            url = NSBundle.mainBundle().URLForResource("assets/\(arrChapTitles[chapterPos])", withExtension:"html")
            if url != nil {
                let urlRequest = NSURLRequest(URL: url!)
                webView.loadRequest(urlRequest)
            } else {
                print("There seems to be an error")
            }
        } else {
            print("Already at end")
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barTintColor = UIColor.grayColor()
        navigationController!.navigationBar.tintColor = UIColor.blackColor()
        
        // Do any additional setup after loading the view.
        
        self.revealViewController().rearViewRevealWidth = 310
        
        // Code used to load webpage
        url = NSBundle.mainBundle().URLForResource(chapterURL, withExtension:"html")

        if url != nil {
            let urlRequest = NSURLRequest(URL: url!)
            webView.loadRequest(urlRequest)
        } else {
            url = NSBundle.mainBundle().URLForResource("assets/\(chapterURL)", withExtension:"html")
            if url != nil {
                let urlRequest = NSURLRequest(URL: url!)
                webView.loadRequest(urlRequest)
            } else {
                print("There seems to be an error")
            }
            
        }
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
