//
//  PhotoCollectionViewController.swift
//  ImageDemo
//
//  Created by TJQ on 16/7/27.
//  Copyright © 2016年 KiraMelody. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PhotoCollectionViewCellDelegate {

    var ImageArray = [UIImage?]()
    var lastSelect: NSIndexPath!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width / 3, height: UIScreen.mainScreen().bounds.width / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        super.init(collectionViewLayout: layout)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.delegate = self
        collectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView!)
        self.collectionView!.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        for _ in 1...9
        {
            ImageArray.append(nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "<九宫格>"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 9
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        willAddImage(indexPath)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier("PhotoCollectionViewCell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        cell.layer.borderColor = UIColor.grayColor().CGColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.photoView.contentMode = .ScaleAspectFit
        cell.delegate = self
        cell.indexPath = indexPath
        if (ImageArray[indexPath.row] != nil)
        {
            cell.photoView.image = ImageArray[indexPath.row]
            cell.addButton.hidden = true
        }
        else
        {
            cell.photoView.image = nil
            cell.addButton.hidden = false
        }
        return cell
    }
    
    func willAddImage (indexPath: NSIndexPath)
    {
        let picker = UIImagePickerController ()
        picker.delegate = self
        let actions = UIAlertController(title: "提示", message: "选取或拍摄照片", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let action1 = UIAlertAction(title: "在图库中选取", style: UIAlertActionStyle.Default) { (action) in
            self.navigationController!.presentViewController(picker, animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
            {
                picker.sourceType = .Camera
                self.navigationController!.presentViewController(picker, animated: true, completion: nil)
            }
            else
            {
                print ("不支持相机")
            }
            
        }
        let action3 = UIAlertAction(title: "取消", style: .Cancel) { (action) in Void() }
        actions.addAction(action1)
        actions.addAction(action2)
        actions.addAction(action3)
        lastSelect = indexPath
        self.navigationController!.presentViewController(actions, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let selectImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        ImageArray[lastSelect.row] = selectImage
        picker.dismissViewControllerAnimated(true, completion: nil)
        collectionView?.reloadItemsAtIndexPaths([lastSelect])
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
