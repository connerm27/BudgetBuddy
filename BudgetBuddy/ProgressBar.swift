//
//  ProgressBar.swift
//  BudgetBuddy
//
//  Created by Conner Montgomery on 5/9/22.
//

import UIKit

class ProgressBar: UIView {

    
    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    
    public var progress: CGFloat = 0 {
        didSet{
            didProgressUpdated()
        }
        
    }
    
    public var progressLabel: CGFloat = 0 {
        didSet{
            didProgressUpdated2()
        }
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        // Drawing code
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.1 * min(width, height)
        
        backgroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.lightGray.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        
        foregroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.blue.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        
        // Display foreground a certain amount
        foregroundLayer.strokeEnd = 0.5
        
        textLayer = createTextLayer(rect: rect, textColor: UIColor.black.cgColor)
        
     
        
        // add as sublayer of root layer
        layer.addSublayer(backgroundLayer)
        
        // add foreground layer
        layer.addSublayer(foregroundLayer)
        
        // add text as sublayer
        layer.addSublayer(textLayer)
        
        
        
        
    }
    
    // function for creating both foreground and back ground circular layers
    private func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        
        // Drawing code
        let width = rect.width
        let height = rect.height
        
        let center = CGPoint(x:width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2
        
        // Start and end angle of the circular path
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        
        
        // create circular path
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        // Create background layer
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        
        
        return shapeLayer
        
    }
    
    private func createTextLayer(rect: CGRect, textColor: CGColor) -> CATextLayer {
        
        let width = rect.width
        let height = rect.height
        
        let fontSize = min(width, height) / 8
        
        let offset = min(width, height) * 0.2
        
        let layer = CATextLayer()
        layer.string = "100"
        layer.backgroundColor = UIColor.clear.cgColor
        layer.foregroundColor = textColor
        layer.frame = CGRect(x:0, y: (height - fontSize - offset) / 2.2, width: width, height: fontSize + offset)
        layer.alignmentMode = .center
        return layer
        
        
        
    }
    
    private func didProgressUpdated() {
        foregroundLayer?.strokeEnd = progress
        
        
    }

    private func didProgressUpdated2() {
        textLayer?.string = "$\(Int(progressLabel))"
   
        
        
    }
    
}
