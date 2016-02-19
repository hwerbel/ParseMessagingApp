//
//  LoginViewController.swift
//  ParseMessagingApp
//
//  Created by user116136 on 2/18/16.
//  Copyright © 2016 Hannah Werbel. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.backgroundColor = UIColor.blueColor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        let user = PFUser()
        user.username = emailField.text
        user.password = passwordField.text
        user.email = emailField.text
        
    user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
        if let error = error {
            let errorString = error.userInfo["error"] as? String
            UIAlertView(title: "Error", message: errorString, delegate: nil, cancelButtonTitle: "Ok").show()
            
        } else {
            print("sign-up successful")
            let chatViewController = ChatViewController()
            self.presentViewController(chatViewController, animated: true, completion: nil)
        }
        }
    }

    @IBAction func onLogin(sender: AnyObject) {
        let username = emailField.text
        let password = passwordField.text
        PFUser.logInWithUsernameInBackground (username!, password: password!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("successfully logged in")
                let chatViewController = ChatViewController()
                self.performSegueWithIdentifier("ChatViewController", sender: nil)
                
                
            } else {
                let errorString = error!.userInfo["error"] as? String
                UIAlertView(title: "Error", message: errorString, delegate: nil, cancelButtonTitle: "Ok").show()
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
