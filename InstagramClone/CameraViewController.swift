//
//  CameraViewController.swift
//  InstagramClone
//
//  Created by Youssef Elabd on 3/19/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import MBProgressHUD


class CameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tempImageView: UIImageView!
    var post: UIImage?
    var caption: String = ""
    
    @IBOutlet weak var captionTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       
    @IBAction func onBrowse(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        self.post = originalImage
        tempImageView.image = self.post
        self.caption = captionTextfield.text!
        print(caption)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onCamera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        vc.showsCameraControls = true
        
        self.present(vc, animated: true, completion: nil)

    }
    @IBAction func onPost(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Post.postUserImage(image: self.post, withCaption: captionTextfield.text!) { (success: Bool, error: Error?) in
            if error == nil {
                print("uploaded succcessfully")
                self.tabBarController?.selectedIndex = 0
            }else {
                print(error?.localizedDescription ?? "")
            }
            MBProgressHUD.hide(for: self.view, animated: true)
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
