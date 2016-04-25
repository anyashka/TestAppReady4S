//
//  EnteringLinkViewController.swift
//  TestAppReady4s
//
//  Created by Anna-Maria Shkarlinska on 25/04/16.
//  Copyright © 2016 Anna-Maria Shkarlinska. All rights reserved.
//

import UIKit
import Alamofire
import CoreData


class EnteringLinkViewController: UIViewController {

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var linkTextField: UITextField!

    let headers = [
        "Content-Type" : "application/json"
    ]
    let APIkey = "?key=AIzaSyByrJR-7SUCtlR24mC3ykPYFfRB02bcrPM"
 
    
    @IBAction func addLink(sender: AnyObject) {
        
        guard let linkEntered = self.linkTextField.text where linkEntered.length > 0 else {
            showAlertWithTitle("Error", message: "Enter a link, please")
            return
        }
        
        guard verifyUrl(linkEntered) else {
            showAlertWithTitle("Error", message: "URL is not valid")
            return
        }
        
        let parameters = [
            "longUrl" : "\(linkEntered)"
        ]
        
        Alamofire.request(.POST, "https://www.googleapis.com/urlshortener/v1/url\(APIkey)", parameters: parameters, encoding: .JSON)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching link: \(response.result.error)")
                    return
                }
                
                guard let responseJSON = response.result.value  else{
                        return
                }
                
                self.parseJSON(responseJSON)
        }
        
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.sharedApplication().canOpenURL(url)
            }
        }
        return false
    }
        
    func parseJSON(response : AnyObject){
        
        let shortUrl = response.valueForKey("id") as! String
        let longUrl = response.valueForKey("longUrl") as! String
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //add new link to CoreData
        let newLink = NSEntityDescription.insertNewObjectForEntityForName("Link", inManagedObjectContext: context) as! Link
        newLink.configure(shortUrl, longURL: longUrl)
        do{
            try context.save()
        }catch{
            print("Error with saving a note")
        }
        showAlertWithTitle("OK", message: "We've got a short link for you! Check out in Fragment 2!")
    }
    
    
    
    func showAlertWithTitle( title:String, message:String ) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        alertVC.addAction(okAction)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.presentViewController(alertVC, animated: true, completion: nil)
            
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        // Do any additional setup after loading the view.
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

}
