//
//  PhotoCollectionViewCell.swift
//  ImageDemo
//
//  Created by TJQ on 16/7/27.
//  Copyright © 2016年 KiraMelody. All rights reserved.
//

import UIKit
import SnapKit
protocol PhotoCollectionViewCellDelegate {
    func willAddImage (indexPath: NSIndexPath)
}
class PhotoCollectionViewCell: UICollectionViewCell, UIImagePickerControllerDelegate {
    var photoView: UIImageView!
    var addButton: UIButton!
    var delegate : PhotoCollectionViewCellDelegate?
    var indexPath: NSIndexPath!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoView = UIImageView()
        addButton = UIButton(type: UIButtonType.ContactAdd)
        contentView.addSubview(photoView)
        contentView.addSubview(addButton)
        photoView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        addButton.snp_makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(20, 20, 20, 20))
        }
        addButton.addTarget(self, action: #selector(PhotoCollectionViewCell.addPhoto), forControlEvents: UIControlEvents.TouchDown)
    }
    
    func addPhoto ()
    {
        self.delegate?.willAddImage(indexPath)
    }
    
}
