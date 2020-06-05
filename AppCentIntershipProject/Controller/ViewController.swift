//
//  ViewController.swift
//  AppCentIntershipProject
//
//  Created by Sevval Armagan on 5.06.2020.
//  Copyright © 2020 Sevval Armagan. All rights reserved.
//

import UIKit
import SnapKit


class ViewController: UIViewController{
    
    var page : Int = 1
    var flickerImageVM = FlickerImageVM()
    let imageVC = ImageVC()
    
    var isPageRefreshing : Bool = false
    let container = UIView()
    func setContainer(){
        view.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(view)
        }
    }
    
    
    let todayLabel = UILabel()
    func setTodayLabel() {
        container.addSubview(todayLabel)
        todayLabel.snp.makeConstraints { (make) -> Void  in
            todayLabel.text = "Last Uploads"
            todayLabel.textColor = .white
            todayLabel.font = todayLabel.font.withSize(30)
            make.height.equalTo(50)
            make.top.equalTo(container).offset(50)
            make.leading.equalTo(container).offset(10)
            make.trailing.equalTo(container).offset(-10)
        }
    }
    
    
    fileprivate let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(flickerImageCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    func setCollectionView(){
        container.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.snp.makeConstraints { (make) -> Void in
            collectionView.layer.cornerRadius = 10.0
            make.top.equalTo(todayLabel.snp.bottom).offset(0)
            make.leading.equalTo(container).offset(20)
            make.trailing.equalTo(container.snp.trailing).offset(-20)
            make.bottom.equalTo(container.snp.bottom)
        }
    }
    
    
    func setupDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(red: 0.149, green: 0.157, blue: 0.184, alpha: 1)
        super.viewDidLoad()
        setContainer()
        setTodayLabel()
        setCollectionView()
        
        setupDelegate()
        
        flickerImageVM.getImage(pageCount: page, completed: {
            response in
            self.flickerImageVM.flickerImageArrayResult = response
        })
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

var id = Int()
extension ViewController: FlickerImageVMDelegate{
    func flickerImageRequestCompleted() {
        
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickerImageVM.flickerImageArrayResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! flickerImageCell
        
        if let farm = flickerImageVM.flickerImageArrayResult[indexPath.row].farm, let server = flickerImageVM.flickerImageArrayResult[indexPath.row].server, let photo = flickerImageVM.flickerImageArrayResult[indexPath.row].id, let secret = flickerImageVM.flickerImageArrayResult[indexPath.row].secret {
            cell.flickerImage.loadImageAsync(with: "https://farm" + String(farm) + ".staticflickr.com/" + String(server) + "/" + String(photo) + "_" + String(secret) + "_b.jpg", completed: {})
        } else {
            print("Unable to retrieve the first room name.")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row ==  flickerImageVM.flickerImageArrayResult.count - 5) {
            self.page = self.page + 1
            DispatchQueue.global(qos: .background).async {
                print("Run on background thread")
                self.flickerImageVM.getImage(pageCount: self.page, completed: {
                    response in
                    self.flickerImageVM.flickerImageArrayResult = response
                }
                )
                DispatchQueue.main.async {
                    self.collectionView.insertItems(at: [indexPath])
                }
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageVC.farm = String( flickerImageVM.flickerImageArrayResult[indexPath.row].farm!)
        imageVC.server = String(flickerImageVM.flickerImageArrayResult[indexPath.row].server! )
        imageVC.photo = String( flickerImageVM.flickerImageArrayResult[indexPath.row].id!)
        imageVC.secret = String( flickerImageVM.flickerImageArrayResult[indexPath.row].secret!)
        
        
        self.navigationController?.pushViewController(imageVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 300, height: 225)
    }
    
    //TODO: Cell'lerin kenarlara olan uzaklıkları
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    
    
}




