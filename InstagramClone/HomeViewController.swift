//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Youssef Elabd on 3/19/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var posts : [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.sectionHeaderHeight = 50
        tableView.sectionFooterHeight = 0
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 320
        
        loadPosts()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPosts()
    }

    
    func loadPosts(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                print(posts)
                self.posts = posts
                self.tableView.reloadData()
                
                // do something with the data fetched
            } else {
                // handle error
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let post = posts[section]
        
        let user =  post["author"] as! PFUser
        try! user.fetchIfNeeded()
        return user.username
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let section = indexPath.section
        
        let postInfo = self.posts[section]
        
        var date: String = ""
        
        let secondsBetween = Int(Date().timeIntervalSince(postInfo.createdAt!))
        
        if secondsBetween < 60 {
            date = "1m"
        }
        else if secondsBetween < 3600 {
            date = "\(secondsBetween / 60)m"
        }
        else if secondsBetween < 86400 {
            date = "\(secondsBetween / 3600)h"
        }
        else {
            date = "\(secondsBetween / 86400)d"
        }
        
        print("Cell caption: \(postInfo["caption"] as! String)")
        
        cell.captionLabel.text = date + " ago, " + (postInfo["caption"] as! String)
        
        let picture = postInfo["media"] as! PFFile
        
        picture.getDataInBackground { (data: Data?, error :Error?) in
            if (error == nil) {
                let image = UIImage(data: data!)
                cell.postView.image = image
                
            }

        }
        
        return cell

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }

    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        loadPosts()
        refreshControl.endRefreshing()
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
