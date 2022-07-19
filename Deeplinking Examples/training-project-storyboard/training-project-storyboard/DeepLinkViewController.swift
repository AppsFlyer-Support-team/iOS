//
//  DeepLinkViewController.swift
//  training-project-storyboard
//
//  Created by Mark Serrano on 3/10/21.
//

import UIKit

class DeepLinkViewController: UIViewController {
    
    var viewColor: String = ""
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBAction func backButtonClick(_ sender: Any) {
        
        print("Back button clicked")
        self.dismiss(animated: true, completion: nil)

    }
    
    
    override func viewDidLoad() {
        
        self.colorLabel.text = self.viewColor
        
        switch viewColor{
        case "blue":
            self.view.backgroundColor = UIColor.blue
        case "red":
            self.view.backgroundColor = UIColor.red
        case "yellow":
            self.view.backgroundColor = UIColor.yellow
        case "green":
            self.view.backgroundColor =
                UIColor.green
        default:
            self.view.backgroundColor =
                UIColor.white
            
        }
        
        
        
        
        super.viewDidLoad()

    }


}
