//
//  flickerImageCell.swift
//  AppCentIntershipProject
//
//  Created by Sevval Armagan on 5.06.2020.
//  Copyright © 2020 Sevval Armagan. All rights reserved.
//

import UIKit

class flickerImageCell: UICollectionViewCell {
    
    let flickerImage : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.black
        return image
    }()
    
    private func  flickerImageContraints(){
        self.contentView.addSubview(flickerImage)
        flickerImage.layer.masksToBounds = true
        flickerImage.layer.cornerRadius = 15.0
        flickerImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    
    override init(frame : CGRect){
        super.init(frame : frame)
        flickerImageContraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  override func awakeFromNib() {
    DispatchQueue.main.async {
        self.flickerImage.layer.cornerRadius = 13.0
        self.flickerImage.layer.shadowColor = UIColor.gray.cgColor
        self.flickerImage.layer.shadowOpacity = 0.5
        self.flickerImage.layer.shadowOpacity = 10.0
        self.flickerImage.layer.shadowOffset = .zero
        self.flickerImage.layer.shadowPath = UIBezierPath(rect: self.flickerImage.bounds).cgPath
        self.flickerImage.layer.shouldRasterize = true
        
    }
           
        }
        
    }

