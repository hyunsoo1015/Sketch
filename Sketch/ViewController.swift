//
//  ViewController.swift
//  Sketch
//
//  Created by 김현수 on 2020/09/16.
//  Copyright © 2020 Hyun Soo Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func setColor(_ sender: Any) {
        let segment = sender as! UISegmentedControl
        
        switch segment.selectedSegmentIndex {
        case 0:
            lineColor = UIColor.black.cgColor
        case 1:
            lineColor = UIColor.red.cgColor
        case 2:
            lineColor = UIColor.green.cgColor
        case 3:
            lineColor = UIColor.blue.cgColor
        default:
            lineColor = UIColor.white.cgColor
        }
    }
    
    @IBAction func setWidth(_ sender: Any) {
        let stepper = sender as! UIStepper
        lineSize = CGFloat(stepper.value)
    }
    
    @IBAction func clear(_ sender: Any) {
        imageView.image = nil
    }
    
    //선색상, 선두께, 좌표를 저장할 변수
    var lineSize: CGFloat = 2.0
    var lineColor = UIColor.black.cgColor
    var lastPoint: CGPoint!
    
    //터치 메소드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //터치가 시작될 때 좌표만 저장
        let touch = touches.first! as UITouch
        lastPoint = touch.location(in: imageView)
    }
    
    //터치가 이동할 때 마다 lastPoint에서 이동한 지점까지 선을 그리고 좌표를 변경
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //그리기 위한 설정
        UIGraphicsBeginImageContext(imageView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        
        //터치한 좌표 찾아오기
        let touch = touches.first! as UITouch
        let currentPoint = touch.location(in: imageView)
        
        //그리는 영역 설정
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
        
        //시작점과 종료점 설정
        UIGraphicsGetCurrentContext()?.move(to: lastPoint)
        UIGraphicsGetCurrentContext()?.addLine(to: currentPoint)
        UIGraphicsGetCurrentContext()?.strokePath()
        
        //메모리에 그린 비트맵을 이미지 뷰에 적용
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //마지막 그린 지점의 좌표를 다음에 그릴 때는 시작 좌표로 설정
        lastPoint = currentPoint
    }
    
    //터치 종료 메소드
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //그리기 위한 설정
        UIGraphicsBeginImageContext(imageView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        
        //그리는 영역 설정
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
        
        //시작점과 종료점 설정
        UIGraphicsGetCurrentContext()?.move(to: lastPoint)
        UIGraphicsGetCurrentContext()?.addLine(to: lastPoint)
        UIGraphicsGetCurrentContext()?.strokePath()
        
        //메모리에 그린 비트맵을 이미지 뷰에 적용
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        imageView.image = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

