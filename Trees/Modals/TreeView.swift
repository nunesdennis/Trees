import UIKit

class TreeView:UIView {
    
    var tree:RBTree?
    var size:CGFloat!
    var root:NodeRBT!
    
    func createNewPosition(nodeReceived:NodeRBT,num:Int){
        if let nodeFather = nodeReceived.nodeFather{
            let node = nodeReceived
            let divider = CGFloat(pow(2.0, Double(num)))
            let nodeSize = Int(size)
            
            if nodeFather.nodeLeft != nil && nodeFather.nodeLeft == node{
                let x = nodeFather.position!.x - root.position!.x/divider
                let y = CGFloat(nodeSize*num + 5 + 5*num)
                node.position = CGPoint(x: x, y: y)
            }else{
                let x = nodeFather.position!.x + root.position!.x/divider
                let y = CGFloat(nodeSize*num + 5 + 5*num)
                node.position = CGPoint(x: x, y: y)
            }
        }
    }
    func createNewLabel(rect:CGRect,key:Int){
        let label = UILabel(frame: rect)
        let fontSize = rect.size.width/2
        label.font = UIFont(name: label.font.fontName, size: fontSize)
        label.textAlignment = .Center
        label.text = "\(key)"
        self.addSubview(label)
    }
    
    func isInternal(node:NodeRBT) -> Bool{
        if node.nodeLeft != nil || node.nodeRight != nil{
            return true
        }
        return false
    }
    func nodeColor(node:NodeRBT)->CGColor{
        if node.cor {
            return UIColor.redColor().CGColor
        }else{
            return UIColor.blackColor().CGColor
        }
    }
    override func drawRect(rect: CGRect) {
        if tree != nil {
            root = tree!.root
            let rootX = rect.width/2-rect.width*0.05
            root.position = CGPoint(x: rootX, y: 0)
            size = rect.width*0.05
            let ctx = UIGraphicsGetCurrentContext()
            CGContextSetStrokeColorWithColor(ctx, nodeColor(root))
            CGContextStrokeEllipseInRect(ctx, CGRectMake(root.position!.x, 0, size, size))
            createNewLabel(CGRectMake(rootX, 0, size, size), key: root.key)
            func insertPositionRecursive(nodeReceived:NodeRBT?,num:Int){
                
                if let node = nodeReceived{
                    if node.position == nil {
                        createNewPosition(node,num: num)
                        let x = node.position!.x
                        let y = node.position!.y
                        CGContextSetStrokeColorWithColor(ctx, nodeColor(node))
                        CGContextStrokeEllipseInRect(ctx, CGRectMake(x,y, size, size))
                        createNewLabel(CGRectMake(x,y, size, size),key:node.key)
                    }
                    if  node.nodeLeft != nil && isInternal(node){insertPositionRecursive(node.nodeLeft,num: num+1)}
                    if  node.nodeRight != nil && isInternal(node){insertPositionRecursive(node.nodeRight,num: num+1)}
                }
                
            }
            insertPositionRecursive(root,num:0)
        }
    }
    
}
