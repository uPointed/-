//
//  ViewController.swift
//  ImagePicker
//
//  Created by 关东升 on 15/1/25.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pickPhotoLibrary(sender: AnyObject) {
        if self.imagePicker == nil {
            self.imagePicker = UIImagePickerController()
        }
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .savedPhotosAlbum
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickPhotoCamera(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            if self.imagePicker == nil {
                self.imagePicker = UIImagePickerController()
            }
            
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            print("照相机不可用。")
        }
    }
    
    // MARK: - 实现UIImagePickerControllerDelegate委托协议
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.imagePicker.delegate = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let originalImage = info[UIImagePickerControllerOriginalImage as NSObject] as! UIImage
        
        self.imageView.image = originalImage
        self.imageView.contentMode = .scaleAspectFill
        self.imagePicker.delegate = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

