//
//  InterfaceController.swift
//  Authum WatchKit 1 Extension
//
//  Created by Andrew Clissold on 7/19/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!

    let names = ["Bananarama", "Chase", "Capital One"]

    override func awakeWithContext(context: AnyObject?) {
        table.setNumberOfRows(names.count, withRowType: "thirdPartyApp")

        for i in 0..<table.numberOfRows {
            guard let thirdPartyAppRowController = table.rowControllerAtIndex(i) as? ThirdPartyAppRowController else {
                fatalError("could not create ThirdPartyAppRowController")
            }
            thirdPartyAppRowController.image.setImageNamed(names[i])
            thirdPartyAppRowController.label.setText(names[i])
        }
    }

}
