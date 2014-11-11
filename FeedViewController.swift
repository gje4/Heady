//
//  FeedViewController.swift
//  Heady
//
//  Created by George Fitzgibbons on 11/10/14.
//  Copyright (c) 2014 Nanigans. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData



class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UICollectionViewDataSource,UICollectionViewDelegate, UINavigationControllerDelegate {


@IBOutlet weak var collectionView: UICollectionView!
    
    //fetch core data image
    var feedArray: [AnyObject] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //load the nsfetch of the ffed array
        
    
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        let request = NSFetchRequest(entityName: "FeedItem")
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        let context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        //grab arry
        feedArray = context.executeFetchRequest(request, error: nil)!
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
    
    
@IBAction func snapBarButtonItemTapped(sender: UIBarButtonItem) {
        
        //phone camera function
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var cameraController: UIImagePickerController = UIImagePickerController()
            cameraController.delegate = self
            cameraController.sourceType = UIImagePickerControllerSourceType.Camera
            
            let mediaType:[AnyObject] = [kUTTypeImage]
            cameraController.mediaTypes = mediaType
            cameraController.allowsEditing = false
            
            self.presentViewController(cameraController, animated: true, completion: nil)
        }
    
    //phone library function
    else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
    
    var photoLibraryController = UIImagePickerController()
    photoLibraryController.delegate = self
    photoLibraryController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    
    let mediaType:[AnyObject] = [kUTTypeImage]
    photoLibraryController.mediaTypes = mediaType
    photoLibraryController.allowsEditing = false
    
    self.presentViewController(photoLibraryController, animated: true, completion: nil)
    }
            
            //defualt to nothing
    else {
    var alertController = UIAlertController(title: "Alert", message: "Your device does not support the camera or photo Library", preferredStyle: UIAlertControllerStyle.Alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    }
    
    
//UIImagePickercontrollerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image:UIImage = info[UIImagePickerControllerOriginalImage] as UIImage
//        println(image)
        
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)

        self.dismissViewControllerAnimated(true, completion: nil)

        
        
        //save image in CoreData
        let managedObjectContext = ((UIApplication.sharedApplication().delegate) as AppDelegate).managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("FeedItem", inManagedObjectContext: managedObjectContext!)
        let feedItem = FeedItem(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        feedItem.image = imageData
        feedItem.caption = "Test Caption!"


        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
        feedArray.append(feedItem)
        self.dismissViewControllerAnimated(true, completion: nil)
        collectionView.reloadData()
    }
    
    
    
    
    
//UICollectionViewDelehate view data source
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println("Feed array count: \(self.feedArray.count)")
        return feedArray.count
    }
    
    //add scrolling
    
    
    //the actuall image that get put togher
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell:FeedCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as FeedCell
        
        let thisItem = feedArray[indexPath.row] as FeedItem
        
        cell.imageView.image = UIImage(data: thisItem.image)
        cell.captionLabel.text = thisItem.caption
        
        //add comments
        
        return cell
    }

    //UICollectionViewDelehate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       let thisItem = feedArray[indexPath.row] as FeedItem
        //get to fileter controller (navigation)

    var filterVC = FilterViewController()
        filterVC.thisFeedItem = thisItem
        
    //push to vc
//        self.navigationController?pushViewController(filterVC, animated: false)
    }

    

}

