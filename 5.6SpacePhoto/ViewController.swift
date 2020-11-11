//
//  ViewController.swift
//  5.6SpacePhoto
//
//  Created by Sophie Kim on 2020/11/11.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var photo: UIImageView!
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
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
    }
}
}
}
    
extension ViewController {
    func updateUI(with photoInfo: PhotoInfo) {
        let task = URLSession.shared.dataTask(with: photoInfo.url, completionHandler: { (data, response, error) in
            
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.title = photoInfo.title
                self.photo.image = image
                self.descriptionLabel.text = photoInfo.description
                    if let copyright = photoInfo.copyright {
                        self.copyrightLabel.text = "Copyright \(copyright)"
                    } else {
                        self.copyrightLabel.isHidden = true
            }
        }
        })
        task.resume()
    }
}

