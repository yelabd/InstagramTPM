//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Youssef Elabd on 3/19/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameTextfield.text ?? ""
        let password = passwordTextfield.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // display view controller that needs to shown after successful login
            }

        }
                
    }

    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextfield.text
        newUser.password = passwordTextfield.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }

        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
