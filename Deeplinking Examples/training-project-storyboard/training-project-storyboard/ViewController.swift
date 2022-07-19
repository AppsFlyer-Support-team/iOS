//
//  ViewController.swift
//  training-project-storyboard
//
//  Created by Mark Serrano on 3/10/21.
//

import UIKit

class ViewController: UIViewController {
    

    

    @IBOutlet weak var installTypeLabel: UILabel!
    
    @IBOutlet weak var mediaSourceLabel: UILabel!
    
    @IBAction func clickNextView(_ sender: Any) {
        
        let deepLinkViewController = self.storyboard?.instantiateViewController(withIdentifier: "deeplinkview") as! DeepLinkViewController

        
        self.present(deepLinkViewController, animated: true, completion: nil)
        print("clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

