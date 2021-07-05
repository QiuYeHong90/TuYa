//
//  SHGraffitiView.swift
//  TuYaDemo
//
//  Created by ray on 2021/7/5.
//
import CoreGraphics
import UIKit

class DrawModel {
    var bpath:UIBezierPath = UIBezierPath.init()
    var path:CGMutablePath = CGMutablePath()
    var color:UIColor = .red
    var list:[CGPoint] = []
}
class SHGraffitiView: UIView {
    enum UIType {
        case bsier
        case normal
    }
    var type:UIType = .bsier
    var currentColor:UIColor = .red
    var oldList:[DrawModel] = []
    var currentModel:DrawModel?
    var context:CGContext? = UIGraphicsGetCurrentContext ()
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        switch type {
        case .normal:
            do{
                //获取绘图上下文
                guard let context = UIGraphicsGetCurrentContext () else {
                    return
                }
                for item in self.oldList {
                    let path = item.path
                    context.addPath(path)
                }
                if let path = self.currentModel?.path {
                    context.addPath(path)
                }
                //设置笔触颜色
                context.setStrokeColor( UIColor .orange.cgColor)
                //设置笔触宽度
                context.setLineWidth(6)
                         
                //绘制路径
                context.strokePath()
            }
        case .bsier:
            for item in self.oldList {
                item.color.setStroke()
//                UIColor.red.setStroke()
                let path = item.bpath
                path.stroke()
            }
            if let path = self.currentModel?.bpath {
                self.currentModel?.color.setStroke()
//                UIColor.red.setStroke()
                path.lineWidth = 5
                path.lineCapStyle = .round
                path.lineJoinStyle = .round
                
                path.stroke()
            }
            break
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else {
            return
        }
        if let old = self.currentModel {
            self.oldList.append(old)
        }
        
        switch self.type {
        case .normal:
            self.currentModel = DrawModel.init()
            self.currentModel?.path.move(to: point)
            self.currentModel?.list.append(point)
        case .bsier:
            self.currentModel = DrawModel.init()
            self.currentModel?.color = self.currentColor
            self.currentModel?.bpath.move(to: point)
            self.currentModel?.list.append(point)
        }
        
        
    }
    func revoke() {
        if self.currentModel == nil {
            if self.oldList.isEmpty {
                return
            }
            self.oldList.removeLast()
        }else{
            self.currentModel = nil
        }
        
        
        self.setNeedsDisplay()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {
            return
        }
        self.currentModel?.list.append(point)
        
        switch self.type {
        case .normal:
            self.currentModel?.path.addLine(to: point)
        case .bsier:
            self.currentModel?.bpath.addLine(to: point)
        }
        self.setNeedsDisplay()
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else {
            return
        }
        
        
        print("touches  \(touches)")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       
        print("touches  \(touches)")
    }
}
