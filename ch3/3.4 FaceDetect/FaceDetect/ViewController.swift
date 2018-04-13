//
//  ViewController.swift
//  FaceDetect
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
    
    @IBOutlet weak var inputImageView: UIImageView!
    
    @IBOutlet weak var outputImageView: UIImageView!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let image = UIImage(named:"faces1.png")
        let image = UIImage(named:"year.jpg")
        
        self.inputImageView.image = image
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func detect(sender: AnyObject) {
        
        let context = CIContext(options: nil)
        let imageInput = self.inputImageView.image
        let image = CIImage(cgImage: (imageInput?.cgImage)!)
        
        //设置识别参数
        let param = [CIDetectorAccuracyHigh : CIDetectorAccuracy]
        
        //声明一个CIDetector，并设定识别类型
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: param)
    
        
        //取得识别结果
        let detectResult = faceDetector?.features(in: image)
        let resultView = UIView(frame: self.inputImageView.frame)
        self.view.addSubview(resultView)
        
        for item in detectResult! {
            let faceFeature = item as! CIFaceFeature
            //脸部
            let faceView = UIView(frame:faceFeature.bounds)
            
            faceView.layer.borderWidth = 1
            faceView.layer.borderColor = UIColor.orange.cgColor
            resultView.addSubview(faceView)
            
            //左眼
            if faceFeature.hasLeftEyePosition {
                let leftEyeView = UIView(frame:CGRect(x: 0, y: 0, width: 5, height: 5))
                leftEyeView.center = faceFeature.leftEyePosition
                leftEyeView.layer.borderWidth = 1
                leftEyeView.layer.borderColor = UIColor.red.cgColor
                resultView.addSubview(leftEyeView)
            }
            
            //右眼
            if faceFeature.hasRightEyePosition {
                let rightEyeView = UIView(frame:CGRect(x: 0, y: 0, width: 5, height: 5))
                rightEyeView.center = faceFeature.rightEyePosition
                rightEyeView.layer.borderWidth = 1	
                rightEyeView.layer.borderColor = UIColor.red.cgColor
                resultView.addSubview(rightEyeView)
            }
            
            //嘴巴
            if faceFeature.hasMouthPosition {
                let mouthView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 5))
                mouthView.center = faceFeature.mouthPosition
                mouthView.layer.borderWidth = 1
                mouthView.layer.borderColor = UIColor.red.cgColor
                resultView.addSubview(mouthView)
            }
        }
        
        resultView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        if (detectResult?.count)! > 0 {
            let faceImage = image.cropped(to: detectResult![0].bounds)
            
            let face = UIImage(cgImage: context.createCGImage(faceImage, from: faceImage.extent)!)
            self.outputImageView.image = face
            
            let buttonTitle = String(format: "识别 人脸数 %i", (detectResult?.count)!)
            self.button.setTitle(buttonTitle, for: .normal)
        }
        
    }
}

