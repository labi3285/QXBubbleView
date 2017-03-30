# QXBubbleView
##A customizable bubble view.

###usage
![](https://github.com/labi3285/QXBubbleView/master/screen_short.png)  
```swift
let bubbleView = QXBubbleView()
bubbleView.arrowPossition = .topLeft
bubbleView.color = UIColor.black
bubbleView.cornerRadius = 3
bubbleView.arrowOffset = 15
bubbleView.arrowSize = CGSize(width: 10, height: 5)
bubbleView.contentInserts = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
view.addSubview(bubbleView)

let content = UILabel()
content.font = UIFont.systemFont(ofSize: 14)
content.textColor = UIColor.white
content.numberOfLines = 0
content.text = "这是什么？\n这是内容"
content.frame = CGRect.zero
content.sizeToFit()

bubbleView.contentSize = content.bounds.size
bubbleView.contentView.addSubview(content)

bubbleView.frame = CGRect(x: 100, y: 100, width: bubbleView.bubbleWidth, height: bubbleView.bubbleHeight)
```

That's all!
