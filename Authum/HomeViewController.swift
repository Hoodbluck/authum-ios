//
//  HomeViewController.swift
//  Authum
//
//  Created by Andrew Clissold on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    let thirdPartyApps = ["Bananarama", "Chase", "Capital One"]
    let thirdPartyCellIdentifier = "thirdPartyAppCell"

    override func viewDidLoad() {
        tableView.backgroundColor = UIColor.whiteColor()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thirdPartyApps.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("thirdPartyAppCell") as? ThirdPartyAppCell
     
        if cell == nil {
            cell = ThirdPartyAppCell(style: .Default, reuseIdentifier: thirdPartyCellIdentifier)
        }
        
        cell?.appNameLabel.text = thirdPartyApps[indexPath.row]
        cell?.appIconImage.image = UIImage(named: thirdPartyApps[indexPath.row])
        
        return cell!
    }
}
