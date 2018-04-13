//
//  ViewController.swift
//  FilterEffects
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

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!
    
    var image : UIImage!
    
    // 0 为CISepiaTone 1 为CIGaussianBlur
    var flag  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image = UIImage(named: "SkyDrive340.png")
        self.imageView.image = self.image
        self.label.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func changeValue(sender: AnyObject) {
        
        let slider  = sender as! UISlider
        var value :Float = slider.value
        
        if self.flag == 0 {
            self.filterSepiaTone(value: value)
        } else if self.flag == 1 {
            self.filterGaussianBlur(value: value)
        }
    }
    
    
    @IBAction func segmentSelected(sender: AnyObject) {
        
        let seg  = sender as! UISegmentedControl
        
        if (seg.selectedSegmentIndex == 0) {//旧色调
            flag = 0;
        } else { //高斯模糊
            flag = 1;
        }
    }
    
    func filterSepiaTone(value : Float) {
        
        let context = CIContext(options: nil)
        let cImage = CIImage.init(cgImage: self.image.cgImage!)

        let sepiaTone = CIFilter(name: "CISepiaTone")
        sepiaTone?.setValue(cImage, forKey: "inputImage")
        
        let text = String(format: "旧色调 Intensity : %.2f", value)
        self.label.text = text
        
        sepiaTone?.setValue(value, forKey: "inputIntensity")
        let result = sepiaTone?.value(forKey: "outputImage") as! CIImage
        
        let imageRef = context.createCGImage(result, from: CGRect(x: 0, y: 0, width: self.imageView.image!.size.width, height: self.imageView.image!.size.height))
        
        let image =  UIImage.init(cgImage: imageRef!)
        self.imageView.image = image
        
        flag = 0
    }
    
    
    func filterGaussianBlur(value : Float) {
        
        let context = CIContext(options: nil)
        let cImage = CIImage.init(cgImage: self.image.cgImage!)
        
        let gaussianBlur = CIFilter(name: "CIGaussianBlur")
        gaussianBlur?.setValue(cImage, forKey: "inputImage")
        
        let text = String(format: "高斯模糊 Radius : %.2f",value * 10)
        self.label.text = text
        
        gaussianBlur?.setValue(value, forKey: "inputRadius")
        let result = gaussianBlur?.value(forKey: "outputImage") as! CIImage
        
        let imageRef = context.createCGImage(result, from: CGRect(x: 0, y: 0, width: self.imageView.image!.size.width, height: self.imageView.image!.size.height))
        
        let image =  UIImage(cgImage: imageRef!)
        self.imageView.image = image
        
        flag = 1
    }
}

