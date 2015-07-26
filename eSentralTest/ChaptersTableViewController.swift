////
//  ChaptersTableViewController.swift
//  eSentralTest
//
//  Created by Daliso Ngoma on 24/07/2015.
//  Copyright © 2015 Daliso Ngoma. All rights reserved.
//

import UIKit
import SwiftyJSON

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class ChaptersTableViewController: UITableViewController {
    
    var chapterURLwHTML = ""
    var chapterURL = ""
    var bookUrlString = "assets/book"
    var chapterCount = 0

    var json:JSON = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.backgroundColor = UIColor(netHex: 0x171817)
        
        let url = NSBundle.mainBundle().URLForResource(bookUrlString, withExtension:"json")
        if (url != nil) {
            json = JSON(data: NSData(contentsOfURL: url!)!)
            
            chapterCount = json["toc"].count + 2
            
            var arrChapTitles = [String]()
            for var i = 0; i < (json["toc"].count); i++ {
                var tempChapTitlewHTML = json["toc"][i]["url"].string!
                let tempChapTitle = tempChapTitlewHTML.substringToIndex(advance(tempChapTitlewHTML.startIndex, (tempChapTitlewHTML as NSString).length - 5))
                arrChapTitles.append(tempChapTitle)
            }
            (UIApplication.sharedApplication().delegate as! AppDelegate).arrChapTitles = arrChapTitles
        } else {
            print("Failing to read book.json")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chapterCount
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chapterCell", forIndexPath: indexPath)
        // Configure the cell...
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        if (indexPath.row == 0) {
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.imageView?.image = UIImage(named: "assets/icon.png")
            cell.textLabel?.text = json["title"].string
        } else if (indexPath.row == 1){
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.textLabel?.backgroundColor = UIColor(netHex: 0x0C0D0C)
            cell.textLabel?.text =  "Table of Content"
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(30.0)
        } else {
            cell.textLabel?.textColor = UIColor.grayColor()
            let chapterName = json["toc"][indexPath.row-2]["title"].string!
            cell.textLabel?.text = "This is \(chapterName)"
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0) {
            return 166
        }
        return 44
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(indexPath.row != 0 && indexPath.row != 1) {
            chapterURLwHTML = json["toc"][indexPath.row-2]["url"].string!
            chapterURL = chapterURLwHTML.substringToIndex(advance(chapterURLwHTML.startIndex, (chapterURLwHTML as NSString).length - 5))
            (UIApplication.sharedApplication().delegate as! AppDelegate).chapterURL = chapterURL
            (UIApplication.sharedApplication().delegate as! AppDelegate).chapterPos = indexPath.row-2
            
            // Used for refreshing the ChapterViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("TARGET_VIEW_CONTROLLER")
            
            let rvc:SWRevealViewController = self.parentViewController! as! SWRevealViewController
            rvc.pushFrontViewController(vc, animated: true)
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
