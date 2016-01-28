//
//  treeBSTP.swift
//  AVLTree
//
//  Created by Dennis da Silva Nunes on 20/10/15.
//
//

import UIKit

public protocol BSTreeP {

    var root:NodeBSTP!{get set}
    var size:Int!{get set}
    
    func search(node:NodeBSTP,key:Int) -> NodeBSTP
    
    func add(key:Int, object:AnyObject)
    
    func remove(key:Int) -> AnyObject
    
    func getNodeFather(node:NodeBSTP) -> NodeBSTP?
    
    func isRoot(node:NodeBSTP) -> Bool
    
    func swapElements(node1:NodeBSTP,node2:NodeBSTP)
    
    func depth(node:NodeBSTP?, num:Int)
    
    func height(node:NodeBSTP?)->Int
    
    func printInOrder(node:NodeBSTP)
    
    func printPreOrder(node:NodeBSTP)
    
    func printPostOrder(node:NodeBSTP)
}