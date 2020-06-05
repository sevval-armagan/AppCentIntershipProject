//
//  ImageVC.swift
//  AppCentIntershipProject
//
//  Created by Sevval Armagan on 6.06.2020.
//  Copyright © 2020 Sevval Armagan. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {
    
    var farm = String()
    var server = String()
    var photo = String()
    var secret = String()
    
    let flickerImage : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.black
        return image
    }()
    
    private func setFlickerImage() {
        view.addSubview(flickerImage)
        flickerImage.contentMode = .scaleAspectFit
        flickerImage.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(view)
        }
    }
    var flickerVM = FlickerImageVM()
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        flickerImage.loadImageAsync(with: "https://farm" + farm + ".staticflickr.com/" + server + "/" + photo + "_" + secret + "_b.jpg", completed: {})
        flickerVM.flickerImageArrayResult.removeAll()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setFlickerImage()
        
    }
    
    
    
}
