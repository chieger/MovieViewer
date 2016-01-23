//
//  MoviesCollectionViewController.swift
//  MovieViewer
//
//  Created by Dustyn August on 1/22/16.
//  Copyright © 2016 ccsfcomputers. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesCollectionViewController: UIViewController, UICollectionViewDataSource{

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [NSDictionary]?
    @IBOutlet weak var networkErrorView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.networkErrorView.hidden = true
        collectionView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.insertSubview(refreshControl, atIndex: 0)
        
       getStuffFromNetwork()


        // Do any additional setup after loading the view.
    }
    
    func getStuffFromNetwork() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            self.collectionView.reloadData()
                    } else {
                        self.networkErrorView.hidden = false
                    }
                }
        });
        task.resume()
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCollectionViewCell", forIndexPath: indexPath) as! MovieCollectionViewCell
        
        let movie = movies![indexPath.row]
//        let title = movie["title"] as! String
//        let overview = movie ["overview"] as! String
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        let posterPath = movie["poster_path"] as! String
        
        let imageUrl = NSURL(string: baseUrl + posterPath)
//        
//        cell.titleLabel.text = title
//        cell.overviewLabel.text = overview
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            cell.posterCollectionView.setImageWithURL(posterUrl!)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            cell.posterCollectionView.image = nil
        }
        
        
        print ("row \(indexPath.row)")

        
        
        return cell
    }
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        self.collectionView.reloadData()
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
