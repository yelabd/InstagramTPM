//
//  ProfileViewController.swift
//  InstagramClone
//
//  Created by Youssef Elabd on 3/20/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
        performSegue(withIdentifier: "logoutSegue", sender: nil)
        
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
