//
//  DrawView.swift
//  Kaleidoscope
//
//  Created by iosdev on 16.3.2016.
//  Copyright © 2016 iosdev. All rights reserved.
//

import UIKit

struct LineArray {
    var listPoints: [CGPoint] = []
}

class DrawView: UIView {
    
    var lines: [Line] = []
    var lines1: [Line] = []
    var lines2: [Line] = []
    var lines3: [Line] = []
    var lines4: [Line] = []
    
    var list: [LineArray] = []
    
    var lastPoint: CGPoint!
    var pathLayer: CAShapeLayer = CAShapeLayer()
    var pathLayer2: CAShapeLayer = CAShapeLayer()
    var pathLayer3: CAShapeLayer = CAShapeLayer()
    var pathLayer4: CAShapeLayer = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        lastPoint = touches.first?.locationInView(self)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let newPoint = touches.first?.locationInView(self)
        lines.append(Line(_start: lastPoint, _end: newPoint!))
        lastPoint = newPoint
        setNeedsDisplay()
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        for line in lines {
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
        }
        CGContextSetLineWidth(context, 2.5)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
        CGContextStrokePath(context)
//        var path = UIBezierPath()
//        for line in lines {
//            path.moveToPoint(line.start)
//            path.addLineToPoint(line.end)
//        }
//        var pathLayer: CAShapeLayer = CAShapeLayer()
//        pathLayer.frame = self.bounds
//        pathLayer.path = path.CGPath
//        pathLayer.strokeColor = UIColor.blackColor().CGColor
//        pathLayer.fillColor = nil
//        pathLayer.lineWidth = 2.5
//        pathLayer.lineJoin = kCALineJoinBevel
//        pathLayer.strokeEnd = 0.0
//        //
//        
//        self.layer.addSublayer(pathLayer)
//        
//        var pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        pathAnimation.duration = 6
//        pathAnimation.fromValue = 0
//        pathAnimation.toValue = 1
//        
//        pathLayer.strokeEnd = 1
//        
//        pathLayer.addAnimation(pathAnimation, forKey: "animateStroke")
        
    }
    
    func clear() {
        self.lines = []
        self.lines1 = []
        self.lines2 = []
        self.lines3 = []
        self.lines4 = []
        pathLayer.removeFromSuperlayer()
        pathLayer2.removeFromSuperlayer()
        pathLayer3.removeFromSuperlayer()
        pathLayer4.removeFromSuperlayer()
        setNeedsDisplay()
    }
    
    func flipVertically() {
        let oy = self.frame.height
//        let ox = self.frame.width
        for line in lines {
            let startPoint = CGPoint(x: line.start.x, y: (oy-line.start.y))
            let endPoint = CGPoint(x: line.end.x, y: (oy-line.end.y))
            lines.append(Line(_start: startPoint, _end: endPoint))
            lines1.append(Line(_start: startPoint, _end: endPoint))
        }
//        setNeedsDisplay()
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
        func rotation2(angle: Double) {
            let originY = self.frame.height/2
            let originX = self.frame.width/2
            let translateTransform = CGAffineTransformMakeTranslation(originX, originY)
            let rotationTransform = CGAffineTransformMakeRotation(CGFloat(angle * M_PI / 180))
            let customRotation = CGAffineTransformConcat(CGAffineTransformConcat( CGAffineTransformInvert(translateTransform), rotationTransform), translateTransform);
            if (angle == 90.0) {
                for line in lines {
                    let newStartPoint = CGPointApplyAffineTransform(line.start, customRotation)
                    let newEndPoint = CGPointApplyAffineTransform(line.end, customRotation)
                    lines.append(Line(_start: newStartPoint, _end: newEndPoint))
                    lines2.append(Line(_start: newStartPoint, _end: newEndPoint))
                    print(lines2.count)
                }
            } else if (angle == 45.0) {
                for line in lines {
                    let newStartPoint = CGPointApplyAffineTransform(line.start, customRotation)
                    let newEndPoint = CGPointApplyAffineTransform(line.end, customRotation)
                    lines.append(Line(_start: newStartPoint, _end: newEndPoint))
                    lines3.append(Line(_start: newStartPoint, _end: newEndPoint))
                    print(lines3.count)
                }
            } else if (angle == 180.0) {
                for line in lines {
                    let newStartPoint = CGPointApplyAffineTransform(line.start, customRotation)
                    let newEndPoint = CGPointApplyAffineTransform(line.end, customRotation)
                    lines.append(Line(_start: newStartPoint, _end: newEndPoint))
                    lines4.append(Line(_start: newStartPoint, _end: newEndPoint))
                    print(lines4.count)
                }
            }
        }
    
        func makeMagic() {
            var path1 = UIBezierPath()
            for line in lines1 {
                path1.moveToPoint(line.start)
                path1.addLineToPoint(line.end)
            }
            
            var path2 = UIBezierPath()
            for line in lines2 {
                path2.moveToPoint(line.start)
                path2.addLineToPoint(line.end)
            }
            
            var path3 = UIBezierPath()
            for line in lines3 {
                path3.moveToPoint(line.start)
                path3.addLineToPoint(line.end)
            }
            
            var path4 = UIBezierPath()
            for line in lines4 {
                path4.moveToPoint(line.start)
                path4.addLineToPoint(line.end)
            }
            pathLayer.frame = self.bounds
            pathLayer.path = path1.CGPath
            pathLayer.strokeColor = UIColor.blackColor().CGColor
            pathLayer.fillColor = nil
            pathLayer.lineWidth = 2.5
            pathLayer.lineJoin = kCALineJoinBevel
            pathLayer.strokeEnd = 0.0
            //
            pathLayer2.frame = self.bounds
            pathLayer2.path = path2.CGPath
            pathLayer2.strokeColor = UIColor.blackColor().CGColor
            pathLayer2.fillColor = nil
            pathLayer2.lineWidth = 2.5
            pathLayer2.lineJoin = kCALineJoinBevel
            pathLayer2.strokeEnd = 0.0
            //
            pathLayer3.frame = self.bounds
            pathLayer3.path = path3.CGPath
            pathLayer3.strokeColor = UIColor.blackColor().CGColor
            pathLayer3.fillColor = nil
            pathLayer3.lineWidth = 2.5
            pathLayer3.lineJoin = kCALineJoinBevel
            pathLayer3.strokeEnd = 0.0
            //
            pathLayer4.frame = self.bounds
            pathLayer4.path = path4.CGPath
            pathLayer4.strokeColor = UIColor.blackColor().CGColor
            pathLayer4.fillColor = nil
            pathLayer4.lineWidth = 2.5
            pathLayer4.lineJoin = kCALineJoinBevel
            pathLayer4.strokeEnd = 0.0
                        
            self.layer.addSublayer(pathLayer)
            self.layer.addSublayer(pathLayer2)
            self.layer.addSublayer(pathLayer3)
            self.layer.addSublayer(pathLayer4)
            
            var pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = 2
            pathAnimation.fromValue = 0
            pathAnimation.toValue = 1
            
            var pathAnimation2 = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation2.duration = 4
            pathAnimation2.fromValue = 0
            pathAnimation2.toValue = 1
            
            var pathAnimation3 = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation3.duration = 4
            pathAnimation3.fromValue = 0
            pathAnimation3.toValue = 1
            
            var pathAnimation4 = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation4.duration = 4
            pathAnimation4.fromValue = 0
            pathAnimation4.toValue = 1
            
            pathLayer.strokeEnd = 1
            pathLayer2.strokeEnd = 1
            pathLayer3.strokeEnd = 1
            pathLayer4.strokeEnd = 1
            pathLayer.addAnimation(pathAnimation, forKey: "animateStroke")
            
            pathLayer2.addAnimation(pathAnimation2, forKey: "animateStroke")
            
            pathLayer3.addAnimation(pathAnimation3, forKey: "animateStroke")
            
            pathLayer4.addAnimation(pathAnimation4, forKey: "animateStroke")
        }
}
