//
//  ViewController.swift
//  5.6SpacePhoto
//
//  Created by Sophie Kim on 2020/11/11.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var copyrightLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
       
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        photoInfoController.fetchPhotoInfo{ (photoInfo) in
            guard let photoInfo = photoInfo else { return }
            DispatchQueue.main.async {
                self.title = photoInfo.title
                self.descriptionLabel.text = photoInfo.description
                    if let copyright = photoInfo.copyright {
                        self.copyrightLabel.text = "Copyright \(copyright)"
                    } else {
                        self.copyrightLabel.isHidden = true
                }
            }
        }
    }
}
