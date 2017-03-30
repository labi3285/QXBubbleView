//
//  QXBubbleView.swift
//  QXBubbleView
//
//  Created by Richard.q.x on 2017/3/30.
//  Copyright © 2017年 labi3285. All rights reserved.
//

import UIKit

enum QXBubbleViewArrowPossition {
    case topLeft
    case topCenter
    case topRight
    case leftTop
    case leftCenter
    case leftBottom
    case rightTop
    case rightCenter
    case rightBottom
    case bottomLeft
    case bottomCenter
    case bottomRight
}

class QXBubbleView: UIView {
    
    /// the possition of the arrow
    var arrowPossition: QXBubbleViewArrowPossition = .topCenter
    /// arrow offset in the short side, when arrowPossition is not center
    var arrowOffset: CGFloat = 15
    /// the size of the arrow, size.height has nothing to do with arrowPossition, which is always the distance between the top-end and the bottom
    var arrowSize: CGSize = CGSize(width: 10, height: 5)
    
    /// the corner radius of the bubble
    var cornerRadius: CGFloat = 3
    
    /// the color of the bubble
    var color: UIColor = UIColor.black
    /// the content size
    var contentSize: CGSize = CGSize(width: 30, height: 30)
    /// the content margins in the top,left,bottom,right
    var contentInserts: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    /// the auto sized content view, you may add subviews in this view, and their constrains should base on this view
    lazy var contentView: UIView = {
        let one = UIView()
        return one
    }()
    
    /// the size of the bubble whole view, which is the same as intrinsicContentSize
    var bubbleSize: CGSize {
        return CGSize(width: bubbleWidth, height: bubbleHeight)
    }
    /// the width of the bubble whole view
    var bubbleWidth: CGFloat {
        switch arrowPossition {
        case .topCenter, .topLeft, .topRight, .bottomLeft, .bottomCenter, .bottomRight:
            return contentSize.width + contentInserts.left + contentInserts.right
        default:
            return contentSize.width + contentInserts.left + contentInserts.right + arrowSize.height
        }
    }
    /// the height of the bubble whole view
    var bubbleHeight: CGFloat {
        switch arrowPossition {
        case .leftTop, .leftCenter, .leftBottom, .rightTop, .rightCenter, .rightBottom:
            return contentSize.height + contentInserts.top + contentInserts.bottom
        default:
            return contentSize.height + contentInserts.top + contentInserts.bottom + arrowSize.height
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return bubbleSize
    }
    
    required init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.clear
        addSubview(contentView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        switch arrowPossition {
        case .topLeft, .topCenter, .topRight:
            contentView.frame = CGRect(x: contentInserts.left,
                                       y: arrowSize.height + contentInserts.top,
                                       width: bubbleWidth - contentInserts.left - contentInserts.right,
                                       height: bubbleHeight - arrowSize.height - contentInserts.top - contentInserts.bottom)
        case .bottomLeft, .bottomCenter, .bottomRight:
            contentView.frame = CGRect(x: contentInserts.left,
                                       y: contentInserts.top,
                                       width: bubbleWidth - contentInserts.left - contentInserts.right,
                                       height: bubbleHeight - arrowSize.height - contentInserts.top - contentInserts.bottom)
        case .leftTop, .leftCenter, .leftBottom:
            contentView.frame = CGRect(x: arrowSize.height + contentInserts.left,
                                       y: contentInserts.top,
                                       width: bubbleWidth - contentInserts.left - contentInserts.right - arrowSize.height,
                                       height: bubbleHeight - contentInserts.top - contentInserts.bottom)
        case .rightTop, .rightCenter, .rightBottom:
            contentView.frame = CGRect(x: contentInserts.left,
                                       y: contentInserts.top,
                                       width: bubbleWidth - contentInserts.left - contentInserts.right - arrowSize.height,
                                       height: bubbleHeight - contentInserts.top - contentInserts.bottom)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        ctx.saveGState()
        
        let pointA: CGPoint
        let pointB: CGPoint
        let pointC: CGPoint
        let pathRect: CGRect
        
        switch arrowPossition {
            
        case .topCenter:
            let ax = rect.width / 2
            pointA = CGPoint(x: ax, y: 0)
            pointB = CGPoint(x: ax + arrowSize.width / 2, y: arrowSize.height)
            pointC = CGPoint(x: ax - arrowSize.width / 2, y: arrowSize.height)
            pathRect = CGRect(x: 0, y: arrowSize.height, width: rect.width, height: rect.height - arrowSize.height)
        case .topLeft:
            let ax = arrowOffset
            pointA = CGPoint(x: ax, y: 0)
            pointB = CGPoint(x: ax + arrowSize.width / 2, y: arrowSize.height)
            pointC = CGPoint(x: ax - arrowSize.width / 2, y: arrowSize.height)
            pathRect = CGRect(x: 0, y: arrowSize.height, width: rect.width, height: rect.height - arrowSize.height)
        case .topRight:
            let ax = bubbleWidth - arrowOffset
            pointA = CGPoint(x: ax, y: 0)
            pointB = CGPoint(x: ax + arrowSize.width / 2, y: arrowSize.height)
            pointC = CGPoint(x: ax - arrowSize.width / 2, y: arrowSize.height)
            pathRect = CGRect(x: 0, y: arrowSize.height, width: rect.width, height: rect.height - arrowSize.height)
            
        case .leftCenter:
            let ay = rect.height / 2
            pointA = CGPoint(x: 0, y: ay)
            pointB = CGPoint(x: arrowSize.height, y: ay - arrowSize.width / 2)
            pointC = CGPoint(x: arrowSize.height, y: ay + arrowSize.width / 2)
            pathRect = CGRect(x: arrowSize.height, y: 0, width: rect.width - arrowSize.height, height: rect.height)
        case .leftTop:
            let ay = arrowOffset
            pointA = CGPoint(x: 0, y: ay)
            pointB = CGPoint(x: arrowSize.height, y: ay - arrowSize.width / 2)
            pointC = CGPoint(x: arrowSize.height, y: ay + arrowSize.width / 2)
            pathRect = CGRect(x: arrowSize.height, y: 0, width: rect.width - arrowSize.height, height: rect.height)
        case .leftBottom:
            let ay = rect.height - arrowOffset
            pointA = CGPoint(x: 0, y: ay)
            pointB = CGPoint(x: arrowSize.height, y: ay - arrowSize.width / 2)
            pointC = CGPoint(x: arrowSize.height, y: ay + arrowSize.width / 2)
            pathRect = CGRect(x: arrowSize.height, y: 0, width: rect.width - arrowSize.height, height: rect.height)
            
        case .rightCenter:
            let ay = rect.height / 2
            pointA = CGPoint(x: bubbleWidth, y: ay)
            pointB = CGPoint(x: bubbleWidth - arrowSize.height, y: ay - arrowSize.width / 2)
            pointC = CGPoint(x: bubbleWidth - arrowSize.height, y: ay + arrowSize.width / 2)
            pathRect = CGRect(x: 0, y: 0, width: rect.width - arrowSize.height, height: rect.height)
        case .rightTop:
            let ay = arrowOffset
            pointA = CGPoint(x: bubbleWidth, y: ay)
            pointB = CGPoint(x: bubbleWidth - arrowSize.height, y: ay - arrowSize.width / 2)
            pointC = CGPoint(x: bubbleWidth - arrowSize.height, y: ay + arrowSize.width / 2)
            pathRect = CGRect(x: 0, y: 0, width: rect.width - arrowSize.height, height: rect.height)
        case .rightBottom:
            let ay = rect.height - arrowOffset
            pointA = CGPoint(x: bubbleWidth, y: ay)
            pointB = CGPoint(x: bubbleWidth - arrowSize.height, y: ay - arrowSize.width / 2)
            pointC = CGPoint(x: bubbleWidth - arrowSize.height, y: ay + arrowSize.width / 2)
            pathRect = CGRect(x: 0, y: 0, width: rect.width - arrowSize.height, height: rect.height)
            
        case .bottomCenter:
            let ax = rect.width / 2
            pointA = CGPoint(x: ax, y: bubbleHeight)
            pointB = CGPoint(x: ax - arrowSize.width / 2, y: bubbleHeight - arrowSize.height)
            pointC = CGPoint(x: ax + arrowSize.width / 2, y: bubbleHeight - arrowSize.height)
            pathRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height - arrowSize.height)
        case .bottomLeft:
            let ax = arrowOffset
            pointA = CGPoint(x: ax, y: bubbleHeight)
            pointB = CGPoint(x: ax - arrowSize.width / 2, y: bubbleHeight - arrowSize.height)
            pointC = CGPoint(x: ax + arrowSize.width / 2, y: bubbleHeight - arrowSize.height)
            pathRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height - arrowSize.height)
        case .bottomRight:
            let ax = rect.width - arrowOffset
            pointA = CGPoint(x: ax, y: bubbleHeight)
            pointB = CGPoint(x: ax - arrowSize.width / 2, y: bubbleHeight - arrowSize.height)
            pointC = CGPoint(x: ax + arrowSize.width / 2, y: bubbleHeight - arrowSize.height)
            pathRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height - arrowSize.height)
            
        }
        ctx.setLineWidth(0)
        ctx.setFillColor(color.cgColor)
        ctx.move(to: pointA)
        ctx.addLine(to: pointB)
        ctx.addLine(to: pointC)
        ctx.closePath()
        let path = UIBezierPath(roundedRect: pathRect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        ctx.addPath(path.cgPath)
        ctx.fillPath()
        ctx.restoreGState()
    }
    
}
