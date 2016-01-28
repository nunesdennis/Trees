//
//  NodeAVLT.swift
//  AVLTree
//
//  Created by Dennis da Silva Nunes on 23/10/15.
//
//

import UIKit

public class NodeAVLT: NSObject,NodeAVLTP,NodeDrawable {
    public var fB:Int!
    public var nodeFather:NodeBSTP?
    public var nodeLeft:NodeBSTP?
    public var nodeRight:NodeBSTP?
    public var key:Int!
    public var object:AnyObject!
    public var position:CGPoint?
    
    public init(key:Int,object:AnyObject,nodeFather:NodeAVLT?){
        self.fB = 0
        self.key = key
        self.object = object
        self.nodeFather = nodeFather
    }
}