//
//  DrawView.swift
//  Kaleidoscope
//
//  Created by iosdev on 16.3.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

struct LineArray {
    var listLine: [Line] = []
}

class DrawView: UIView {
    
    var list: [LineArray] = []
    var listLayer: [CAShapeLayer] = []
    var lastPoint: CGPoint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        for i in 0...15 {
            list.append(LineArray())
            listLayer.append(CAShapeLayer())
        }
        self.clipsToBounds = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastPoint = touches.first?.locationInView(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let newPoint = touches.first?.locationInView(self)
        list[0].listLine.append(Line(_start: lastPoint, _end: newPoint!))
        list[1].listLine.append(Line(_start: rotation2(lastPoint, angle: 45), _end: rotation2(newPoint!, angle: 45)))
        list[2].listLine.append(Line(_start: rotation2(lastPoint, angle: 90), _end: rotation2(newPoint!, angle: 90)))
        list[3].listLine.append(Line(_start: rotation2(lastPoint, angle: 135), _end: rotation2(newPoint!, angle: 135)))
        list[4].listLine.append(Line(_start: rotation2(lastPoint, angle: 180), _end: rotation2(newPoint!, angle: 180)))
        list[5].listLine.append(Line(_start: rotation2(lastPoint, angle: 225), _end: rotation2(newPoint!, angle: 225)))
        list[6].listLine.append(Line(_start: rotation2(lastPoint, angle: 270), _end: rotation2(newPoint!, angle: 270)))
        list[7].listLine.append(Line(_start: rotation2(lastPoint, angle: 315), _end: rotation2(newPoint!, angle: 315)))
        list[8].listLine.append(Line(_start: rotateFlippedPoint(lastPoint, angle: 0), _end: rotateFlippedPoint(newPoint!, angle: 0)))
        list[9].listLine.append(Line(_start: rotateFlippedPoint(lastPoint, angle: 45), _end: rotateFlippedPoint(newPoint!, angle: 45)))
        list[10].listLine.append(Line(_start: rotateFlippedPoint(lastPoint, angle: 90), _end: rotateFlippedPoint(newPoint!, angle: 90)))
        list[11].listLine.append(Line(_start: rotateFlippedPoint(lastPoint, angle: 135), _end: rotateFlippedPoint(newPoint!, angle: 135)))
        list[12].listLine.append(Line(_start: rotateFlippedPoint(lastPoint, angle: 180), _end: rotateFlippedPoint(newPoint!, angle: 180)))
        list[13].listLine.append(Line(_start: rotateFlippedPoint(lastPoint, angle: 225), _end: rotateFlippedPoint(newPoint!, angle: 225)))
        list[14].listLine.append(Line(_start: rotateFlippedPoint(lastPoint, angle: 270), _end: rotateFlippedPoint(newPoint!, angle: 270)))
        list[15].listLine.append(Line(_start: rotateFlippedPoint(lastPoint, angle: 315), _end: rotateFlippedPoint(newPoint!, angle: 315)))
        
        lastPoint = newPoint
        setNeedsDisplay()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        for line in list[0].listLine {
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
        }
        CGContextSetLineWidth(context, 2.5)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
        CGContextStrokePath(context)
    }
    
    func clear() {
        for i in 0...15 {
            list[i].listLine = []
            listLayer[i].removeFromSuperlayer()
        }
        setNeedsDisplay()
    }
    
    func flipVertically(point: CGPoint) -> CGPoint {
        let oy = self.frame.height
        let newPoint = CGPoint(x: point.x, y: oy-point.y)
        return newPoint
    }
    
    
    //Rotate a point arount a point mathematically
//        func rotation(angle: Double) {
//            var radian = M_PI * angle / 180
//            var originY = self.frame.height/2
//            var originX = self.frame.width/2
//            for line in lines {
//                var newXStart = (line.start.x-originX)*CGFloat(cos(radian)) - (line.start.y-originY)*CGFloat(sin(radian)) + originX
//                var newYStart = (line.start.x-originX)*CGFloat(sin(radian)) + (line.start.y-originY)*CGFloat(cos(radian)) + originY
//                var newXEnd = (line.end.x-originX)*CGFloat(cos(radian)) - (line.end.y-originY)*CGFloat(sin(radian)) + originX
//                var newYEnd = (line.end.x-originX)*CGFloat(sin(radian)) + (line.end.y-originY)*CGFloat(cos(radian)) + originY
//                lines.append(Line(_start: CGPoint(x: newXStart, y: newYStart), _end: CGPoint(x: newXEnd, y: newYEnd)))
//            }
//            setNeedsDisplay()
//        }
    
    //Rotate a point arount a point programatically
    func rotation2(point:CGPoint, angle: Double) -> CGPoint {
            let originY = self.frame.height/2
            let originX = self.frame.width/2
            let translateTransform = CGAffineTransformMakeTranslation(originX, originY)
            let rotationTransform = CGAffineTransformMakeRotation(CGFloat(angle * M_PI / 180))
            let customRotation = CGAffineTransformConcat(CGAffineTransformConcat( CGAffineTransformInvert(translateTransform), rotationTransform), translateTransform);
            var newPoint = CGPointApplyAffineTransform(point, customRotation)
            return newPoint
    }
    
    func rotateFlippedPoint(point: CGPoint, angle: Double) -> CGPoint {
        let flippedPoint = flipVertically(point)
        let rotatedPoint = rotation2(flippedPoint, angle: angle)
        return rotatedPoint
    }
    
        func makeMagic() {
            for i in 0...15 {
                var path = UIBezierPath()
                for line in list[i].listLine {
                    path.moveToPoint(line.start)
                    path.addLineToPoint(line.end)
                }
                listLayer[i].frame = self.bounds
                listLayer[i].path = path.CGPath
                listLayer[i].strokeColor = UIColor.blackColor().CGColor
                listLayer[i].fillColor = nil
                listLayer[i].lineWidth = 2.5
                listLayer[i].lineJoin = kCALineJoinRound
                listLayer[i].strokeEnd = 0.0
                
                self.layer.addSublayer(listLayer[i])
            }

            
            var pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = 3
            pathAnimation.fromValue = 0
            pathAnimation.toValue = 1
            
            for i in 0...15 {
                listLayer[i].strokeEnd = 1
                listLayer[i].addAnimation(pathAnimation, forKey: "animateStroke")
            }
        }
}
