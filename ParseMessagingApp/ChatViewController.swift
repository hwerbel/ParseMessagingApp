//
//  ChatViewController.swift
//  ParseMessagingApp
//
//  Created by user116136 on 2/18/16.
//  Copyright © 2016 Hannah Werbel. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatField: UITextField!
    var messages: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "getMessages", userInfo: nil, repeats: true)
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if messages.count != 0 {
            return messages.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell", forIndexPath: indexPath) as! MessageCell
        
        cell.message = messages[indexPath.row] as! String
        
        return cell
    }
    
    func getMessages() {
        var query = PFQuery(className: "Message")
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                print("successfully retrieved \(objects!.count) messages")
                self.messages = objects!
                print(self.messages)
            } else {
                print("error retrieveing messages \(error)")
            }
        
        }
    }
   
    @IBAction func onSend(sender: AnyObject) {
        var chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatField.text
        chatMessage.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("saved message successfully")
            } else {
                print("failed to save message")
            }
        }
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
