//
//  ViewController.swift
//  LastFM
//
//  Created by Client1 on 09.11.15.
//  Copyright © 2015 Client1. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var artistname: UITextField!
    
    @IBOutlet weak var album: UITextField!
    @IBOutlet weak var count: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    
    var test = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistname.text = test
        // Do any additional setup after loading the view, typically from a nib.
        let searchString = "http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=" +
            test + "&api_key=a65d06953de344d726c8f5a324f2aaad&format=json".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let url = NSURL(string: searchString)
        let request = NSURLSession.sharedSession().dataTaskWithURL(url!)
            {(data, response, error) in
                do
                {
                    let result = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                }
                catch let error as NSError
                {
                    NSLog("ERROR")
                }
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    // do some task
                    
                    
                    
                    var ArtistName = ""
                    var AlbumName = ""
                    var PlayCount = 0
                    var ImageUrl = ""
                    var Image: UIImage!
                    
                    //  var data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                    do {
                        var json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                        
                        if let dict = json as? [String: AnyObject] {
                            if let topalbums = dict["topalbums"] as? NSDictionary {
                                if let album = topalbums["album"] as? NSArray {
                                    if let artist = album[0]["artist"] as? NSDictionary {
                                        ArtistName = (artist["name"] as? String!)!
                                    }
                                    AlbumName = (album[0]["name"] as? String!)!
                                    PlayCount = (album[0]["playcount"] as? Int!)!
                                    if let image = album[0]["image"] as? NSArray {
                                        ImageUrl = (image[0]["#text"] as? String!)!
                                    }
                                }
                            }
                        }
                        let url = NSURL(string: ImageUrl)
                        if let data = NSData(contentsOfURL: url!) {
                            Image = UIImage(data: data)
                        }
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.artistname.text = ArtistName
                            self.album.text = AlbumName
                            self.count.text = String(PlayCount)
                            self.image.image = Image
                        }

                    }
                    catch{
                        
                    }
                }
        }
        request.resume()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}

