//
//  AVLTree.swift
//  AVLTree
//
//  Created by Dennis da Silva Nunes on 23/10/15.
//
//
import UIKit

public class AVLTree: AVLTreeP {
    
    public init(rootKey:Int,rootObject:AnyObject){
        root = NodeAVLT(key: rootKey, object: rootObject, nodeFather: nil)
        size = 1
    }
    
    //Binary Tree Search Variables
    
    public var root:NodeBSTP!
    public var size:Int!
    
    //AVL Tree Methods
    
    public func rotateLeft(node:NodeAVLTP){
        let nodeX = node.nodeFather as? NodeAVLT
        let nodeV = node as! NodeAVLT
        let nodeY = node.nodeRight as! NodeAVLT
        let nodeYLeft = nodeY.nodeLeft as? NodeAVLT
        
        if nodeV == root as! NodeAVLT {root = nodeY}
        if nodeX?.nodeLeft as? NodeAVLT == nodeV {
            nodeX?.nodeLeft = nodeY
        }else if nodeX?.nodeRight as? NodeAVLT == nodeV{
            nodeX?.nodeRight = nodeY
        }
        nodeV.nodeFather = nodeY
        nodeY.nodeLeft = nodeV
        nodeY.nodeFather = nodeX
        nodeYLeft?.nodeFather = nodeV
        nodeV.nodeRight = nodeYLeft
        //Esse resetFB não é a maneira certa de fazer.
        resetFB(nodeV, nodeY)
    }
    public func resetFB(nodeV:NodeAVLT,_ fatherNodeV:NodeAVLT){
        nodeV.fB = 0
        fatherNodeV.fB = 0
    }
    
    public func doubleRotateLeft(node:NodeAVLTP){
        let nodeRight = node.nodeRight as! NodeAVLT
        rotateRight(nodeRight)
        rotateLeft(node)
    }
    public func rotateRight(node:NodeAVLTP){
        
        let nodeX = node.nodeFather as? NodeAVLT
        let nodeV = node as! NodeAVLT
        let nodeY = node.nodeLeft as! NodeAVLT
        let nodeYRight = nodeY.nodeRight as? NodeAVLT
        
        if nodeV == root as! NodeAVLT {root = nodeY}
        if nodeX?.nodeRight as? NodeAVLT == nodeV {
            nodeX?.nodeRight = nodeY
        }else if nodeX?.nodeLeft as? NodeAVLT == nodeV{
            nodeX?.nodeLeft = nodeY
        }
        nodeV.nodeFather = nodeY
        nodeY.nodeRight = nodeV
        nodeY.nodeFather = nodeX
        nodeYRight?.nodeFather = nodeV
        nodeV.nodeLeft = nodeYRight
        
        resetFB(nodeV, nodeY)
    }
    
    public func doubleRotateRight(node:NodeAVLTP){
        let nodeLeft = node.nodeLeft as! NodeAVLT
        rotateLeft(nodeLeft)
        rotateRight(node)
    }
    
    public func addFBPoint(node:NodeAVLT,point:Int){
        if point>0 {
            node.fB = node.fB + 1
        }else{
            node.fB = node.fB - 1
        }
        if isFBPointOk(node){
            if node.fB == 0 {
                return
            }else if node.nodeFather != nil{
                let nodeFather = node.nodeFather as! NodeAVLT
                if nodeFather.nodeLeft != nil && nodeFather.nodeLeft as! NodeAVLT == node {
                    addFBPoint(node.nodeFather! as! NodeAVLT, point: 1)
                }else{
                    addFBPoint(node.nodeFather! as! NodeAVLT, point: -1)
                }
            }
        }else{
            activateRotation(node)
        }
    }
    public func reduceFBPoint(node:NodeAVLT,point:Int){
        
    }
    
    public func activateRotation(node:NodeAVLT){
        if node.fB == 2 {
            if node.nodeLeft != nil && (node.nodeLeft! as! NodeAVLT).fB >= 0{
                rotateRight(node)
            }else if node.nodeLeft != nil && (node.nodeLeft! as! NodeAVLT).fB < 0{
                doubleRotateRight(node)
            }
        }else if node.fB == -2{
            if node.nodeRight != nil && (node.nodeRight! as! NodeAVLT).fB <= 0{
                rotateLeft(node)
            }else if node.nodeRight != nil && (node.nodeRight! as! NodeAVLT).fB > 0{
                doubleRotateLeft(node)
            }
        }
    }
    
    public func isFBPointOk(node:NodeAVLT) -> Bool{
        if node.fB > 1 || node.fB < -1 {
            return false
        }else{
            return true
        }
    }
    
    //Binary Tree Search Methods
    
    public func depth(node:NodeBSTP?, num:Int){
        if(node != nil){
            depth(node?.nodeRight, num: num+1)
            print("\(node?.key)" + " (" + "\(num)" + ")");
            depth(node?.nodeLeft, num: num+1)
        }
    }
    public func height(node:NodeBSTP?)->Int{
        if(node == nil){
            return -1
        }

        let hleft = height(node?.nodeRight);
        let hright = height(node?.nodeLeft);

        if(hleft > hright){
            return hleft + 1
        }else{
            return hright + 1
        }
    }

    
    public func find(key:Int) -> NodeBSTP{
        return search(root, key: key)
    }
    
    public func search(node:NodeBSTP,key:Int) -> NodeBSTP{
        if isExternal(node) {
            return node
        }
        if key < node.key {
            if node.nodeLeft != nil{
                return search(node.nodeLeft!, key: key)
            }else{
                return node
            }
        }else if key > node.key{
            if node.nodeRight != nil{
                return search(node.nodeRight!, key: key)
            }else{
                return node
            }
        }else{
            return node
        }
    }
    
    public func add(key:Int, object:AnyObject){
        let nodeFound = find(key) as! NodeAVLT

        if nodeFound.key == key {
            //Node Existente
        }else if nodeFound.key > key {
            let newNode = NodeAVLT(key: key, object: object, nodeFather: nodeFound)
            nodeFound.nodeLeft = newNode
            addFBPoint(nodeFound, point: 1)
        }else{
            let newNode = NodeAVLT(key: key, object: object, nodeFather: nodeFound)
            nodeFound.nodeRight = newNode
            addFBPoint(nodeFound, point: -1)
        }
    }
    
    public func remove(key:Int) -> AnyObject{
        let nodeFound = find(key) as! NodeAVLT
        if isExternal(nodeFound){
            if nodeFound.key == key {
                let point = getNodePointToRemove(nodeFound)
                reduceFBPoint(nodeFound, point: point)
                removeNode(nodeFound)
            }
        }else{
            //Pegar o nó a ser removido e que será feito o swap
        }
        
        return root as! AnyObject
    }
    public func getNodePointToRemove(node:NodeAVLT)->Int{
        let nodeFather = node.nodeFather
        if nodeFather?.nodeLeft as? NodeAVLT == node {
            return -1
        }else{
            return 1
        }
    }
    public func removeNode(node:NodeAVLT){
        
    }
    public func getNodeFather(node:NodeBSTP) -> NodeBSTP?{
        return node.nodeFather
    }
    
    public func isRoot(node:NodeBSTP) -> Bool{
        return true
    }
    
    public func swapElements(node1:NodeBSTP,node2:NodeBSTP){}

    public func printInOrder(){
        printInOrder(self.root)
    }
    public func printInOrder(node:NodeBSTP){
        if  node.nodeLeft != nil && isInternal(node){printInOrder(node.nodeLeft!)}
        print(node.object)
        if  node.nodeRight != nil && isInternal(node){printInOrder(node.nodeRight!)}
    }
    public func printPreOrder(){
        printPreOrder(root)
    }
    public func printPreOrder(node:NodeBSTP){
        print(node.object)
        if  node.nodeLeft != nil && isInternal(node){printPreOrder(node.nodeLeft!)}
        if  node.nodeRight != nil && isInternal(node){printPreOrder(node.nodeRight!)}
    }
    public func printPostOrder(){
        printPostOrder(root)
    }
    public func printPostOrder(node:NodeBSTP){
        if  node.nodeLeft != nil && isInternal(node){printPostOrder(node.nodeLeft!)}
        if  node.nodeRight != nil && isInternal(node){printPostOrder(node.nodeRight!)}
        print(node.object)
    }
    
    //Generic Tree Methods
    
    public func isInternal(node:NodeBSTP) -> Bool{
        if node.nodeLeft != nil || node.nodeRight != nil{
            return true
        }
            return false
    }
    
    public func isExternal(node:NodeBSTP) -> Bool{
        if node.nodeRight == nil && node.nodeLeft == nil {
            return true
        }
            return false
    }
}