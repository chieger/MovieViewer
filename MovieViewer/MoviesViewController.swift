//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by ccsfcomputers on 1/19/16.
//  Copyright © 2016 ccsfcomputers. All rights reserved.
//


//
// Don't forget to check out the guides on courses.codepath.com
//
// Network error:
//          If I have the network error message hidden then I can simply check if there is a network error
//          and then unhide the message if there is. When the error gets fixed hide it again.
//
//
// Collection View:
//          Probably want to swipe to see a new page for collection view.
//          Gid vs Lines
//
//
// Search for a movie:
//          UISearchBar
//
// Image Fade:
//
//
// Custom UI:
//
//



import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var networkErrorTableView: UIView!
    
    
    var movies: [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.networkErrorTableView.hidden = true

        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        getStuffFromNetwork()
        

        // Do any additional setup after loading the view.
    }
    
    
    func getStuffFromNetwork() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
            
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                        // NSLog("response: \(responseDictionary)")
                        
                        MBProgressHUD.hideHUDForView(self.view, animated: true)
                        
                        self.movies = responseDictionary["results"] as? [NSDictionary]
                        self.tableView.reloadData()
                        self.networkErrorTableView.hidden = true
                        
                        
                    }
                } else {
                    self.networkErrorTableView.hidden = false
                    self.tableView.reloadData()
                    
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    self.getStuffFromNetwork()
                }
                
                
                
        });
        task.resume()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie ["overview"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        let posterPath = movie["poster_path"] as! String
        
        let imageUrl = NSURL(string: baseUrl + posterPath)
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            cell.posterView.setImageWithURL(posterUrl!)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            cell.posterView.image = nil
        }
        
       
        print ("row \(indexPath.row)")
        return cell
    }

    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        self.tableView.reloadData()
        getStuffFromNetwork()
        refreshControl.endRefreshing()
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
