//
//  RBTree.swift
//  Trees
//
//  Created by Dennis da Silva Nunes on 26/01/16.
//
//

import UIKit

class RBTree:NSObject {
    
    var root:NodeRBT!
    var size:Int!
    
    
    init(rootKey:Int,rootObject:AnyObject){
        root = NodeRBT(key: rootKey, object: rootObject, nodeFather: nil,cor: false)
        size = 1
    }
    //Passe o grandFather
    func rotateLeft(node:NodeRBT){
        let nodeX = node.nodeFather
        let nodeV = node
        let nodeY = node.nodeRight
        let nodeYLeft = nodeY?.nodeLeft
        
        if nodeV == root {root = nodeY}
        if nodeX?.nodeLeft == nodeV {
            nodeX?.nodeLeft = nodeY
        }else if nodeX?.nodeRight == nodeV{
            nodeX?.nodeRight = nodeY
        }
        nodeV.nodeFather = nodeY
        nodeY?.nodeLeft = nodeV
        nodeY?.nodeFather = nodeX
        nodeYLeft?.nodeFather = nodeV
        nodeV.nodeRight = nodeYLeft
        
    }
    func doubleRotateLeft(node:NodeRBT){
        let nodeRight = node.nodeRight
        rotateRight(nodeRight!)
        rotateLeft(node)
    }
    func rotateRight(node:NodeRBT){
        
        let nodeX = node.nodeFather
        let nodeV = node
        let nodeY = node.nodeLeft
        let nodeYRight = nodeY?.nodeRight
        
        if nodeV == root {root = nodeY}
        if nodeX?.nodeRight == nodeV {
            nodeX?.nodeRight = nodeY
        }else if nodeX?.nodeLeft == nodeV{
            nodeX?.nodeLeft = nodeY
        }
        nodeV.nodeFather = nodeY
        nodeY?.nodeRight = nodeV
        nodeY?.nodeFather = nodeX
        nodeYRight?.nodeFather = nodeV
        nodeV.nodeLeft = nodeYRight
        
    }
    
    func doubleRotateRight(node:NodeRBT){
        let nodeLeft = node.nodeLeft
        rotateLeft(nodeLeft!)
        rotateRight(node)
    }
    
    func depth(node:NodeRBT?, num:Int){
        if(node != nil){
            depth(node?.nodeRight, num: num+1)
            print("\(node?.key)" + " (" + "\(num)" + ")");
            depth(node?.nodeLeft, num: num+1)
        }
    }
    
    func height(node:NodeRBT?)->Int{
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
    
    func find(key:Int) -> NodeRBT{
        return search(root, key: key)
    }
    
    func search(node:NodeRBT,key:Int) -> NodeRBT{
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
    func add(key:Int, object:AnyObject){
        let nodeFound = find(key)
        
        if nodeFound.key == key {
            //Node Existente
        }else if nodeFound.key > key {
            let newNode = NodeRBT(key: key, object: object, nodeFather: nodeFound,cor: true)
            nodeFound.nodeLeft = newNode
            //Adicionou no lado esquerdo
            verificadorInsercao(newNode)
        }else{
            let newNode = NodeRBT(key: key, object: object, nodeFather: nodeFound,cor: true)
            nodeFound.nodeRight = newNode
            //Adicionou no lado direito
            verificadorInsercao(newNode)
        }
    }
    
    func verificadorInsercao(nodeV:NodeRBT){
        print("/////////")
        //Caso 1: Se nodeFather é negro, nada mais precisa ser feito
        if let n1 = verificaCaso1(nodeV){
            //Caso 2: Suponha nodeFather rubro e nodeGrandFather negro, se nodeUncle é rubro, é preciso fazer a recoloração de nodeGrandFather->(rubro),nodeUncle->(negro) e nodeFather->(negro),caso o nodeGreatGrandFather for rubro, o processo deverá ser repetido fazendo nodeV = nodeGrandFather
            if let n2 = verificaCaso2(n1){
                //Caso 3: Suponha nodeFather rubro, nodeGrandFather negro, nodeUncle negro...deve ser feito uma rotação com nodeFather,nodeV,nodeGrandFather e nodeUncle
                if let n3 = verificaCaso3(n2){
                    if root.cor {correcaoRoot();verificadorInsercao(n3)}
                }
            }else{if root.cor {root.cor = false};verificadorInsercao(nodeV)}
        }
    }
    func correcaoRoot(){
        print("Correção de Root")
        root.cor = false
        root?.nodeLeft?.cor = true
        root?.nodeRight?.cor = true
    }
    func acharTio(nodeV:NodeRBT)->NodeRBT?{
        let nodeFather = nodeV.nodeFather
        let nodeGrandFather = nodeV.nodeFather?.nodeFather
        if nodeGrandFather?.nodeLeft == nodeFather {
            return nodeGrandFather?.nodeRight
        }else{
            return nodeGrandFather?.nodeLeft
        }
    }
    func verificaCaso1(node:NodeRBT?)->NodeRBT?{
        guard let nodeV = node else {return nil}
        print("Caso 1")
        if !nodeV.nodeFather!.cor{
            return nil
        }
        return nodeV
    }
    func verificaCaso2(node:NodeRBT?)->NodeRBT?{
        guard let nodeV = node else {return nil}
        print("Caso 2")
        guard let nodeFather = nodeV.nodeFather else {return nodeV}
        guard let nodeGrandFather = nodeV.nodeFather?.nodeFather else {return nodeV}
        guard let nodeUncle = acharTio(nodeV) else {return nodeV}
        
        if nodeFather.cor && !nodeGrandFather.cor && nodeUncle.cor{
            nodeFather.cor = false
            nodeGrandFather.cor = true
            nodeUncle.cor = false
            if let nodeGreatGrandFather = nodeGrandFather.nodeFather {
                if nodeGreatGrandFather.cor {
                    return verificaCaso2(nodeGrandFather)
                }
            }
        }else{return nodeV}
        return nil
    }
    func verificaCaso3(node:NodeRBT?)->NodeRBT?{
        guard let nodeV = node else {return nil}
        print("Caso 3")
        guard let nodeFather = nodeV.nodeFather else {return nodeV}
        guard let nodeGrandFather = nodeV.nodeFather?.nodeFather else {return nodeV}
        let nodeUncle = acharTio(nodeV)
        if nodeFather.cor && !nodeGrandFather.cor{
            if nodeUncle == nil || !nodeUncle!.cor{
                if nodeGrandFather.nodeRight != nodeFather {
                    if nodeFather.nodeLeft == nodeV {
                        return verificaCaso3a(nodeV)
                    }
                    return verificaCaso3d(nodeV)
                }else{
                    if nodeFather.nodeLeft == nodeV {
                        return verificaCaso3c(nodeV)
                    }
                    return verificaCaso3b(nodeV)
                }
            }
        }
        
        return nil
    }
    func verificaCaso3a(node:NodeRBT?)->NodeRBT?{
        guard let nodeV = node else {return nil}
        print("Caso 3a")
        guard let nodeFather = nodeV.nodeFather else {return nodeV}
        guard let nodeGrandFather = nodeV.nodeFather?.nodeFather else {return nodeV}
        rotateRight(nodeGrandFather)
        nodeGrandFather.cor = true
        nodeFather.cor = false
        return nil
    }
    
    func verificaCaso3b(node:NodeRBT?)->NodeRBT?{
        guard let nodeV = node else {return nil}
        print("Caso 3b")
        guard let nodeFather = nodeV.nodeFather else {return nodeV}
        guard let nodeGrandFather = nodeV.nodeFather?.nodeFather else {return nodeV}
        rotateLeft(nodeGrandFather)
        nodeGrandFather.cor = true
        nodeFather.cor = false
        return nil
    }
    
    func verificaCaso3c(node:NodeRBT?)->NodeRBT?{
        guard let nodeV = node else {return nil}
        print("Caso 3c")
        guard let nodeGrandFather = nodeV.nodeFather?.nodeFather else {return nodeV}
        doubleRotateLeft(nodeGrandFather)
        nodeGrandFather.cor = true
        nodeV.cor = false
        return nil
    }
    
    func verificaCaso3d(node:NodeRBT?)->NodeRBT?{
        guard let nodeV = node else {return nil}
        print("Caso 3d")
        guard let nodeGrandFather = nodeV.nodeFather?.nodeFather else {return nodeV}
        doubleRotateRight(nodeGrandFather)
        nodeGrandFather.cor = true
        nodeV.cor = false
        return nil
    }
    
    func remove(key:Int) -> AnyObject{
        let nodeFound = find(key)
        if isExternal(nodeFound){
            if nodeFound.key == key {
                //Achou node a ser removido
                //FALTA ADICIONAR AS REGRAS
                removeNode(nodeFound)
            }
        }else{
            //Pegar o nó a ser removido e que será feito o swap
        }
        
        return root
    }
    func removeNode(node:NodeRBT){
        //FALTA ADICIONAR AS REGRAS
    }
    func printInOrder(){
        printInOrder(self.root)
    }
    func printInOrder(node:NodeRBT){
        if  node.nodeLeft != nil && isInternal(node){printInOrder(node.nodeLeft!)}
        print(node.object)
        if  node.nodeRight != nil && isInternal(node){printInOrder(node.nodeRight!)}
    }
    func printPreOrder(){
        printPreOrder(root)
    }
    func printPreOrder(node:NodeRBT){
        print(node.object)
        if  node.nodeLeft != nil && isInternal(node){printPreOrder(node.nodeLeft!)}
        if  node.nodeRight != nil && isInternal(node){printPreOrder(node.nodeRight!)}
    }
    func printPostOrder(){
        printPostOrder(root)
    }
    func printPostOrder(node:NodeRBT){
        if  node.nodeLeft != nil && isInternal(node){printPostOrder(node.nodeLeft!)}
        if  node.nodeRight != nil && isInternal(node){printPostOrder(node.nodeRight!)}
        print(node.object)
    }
    func isInternal(node:NodeRBT) -> Bool{
        if node.nodeLeft != nil || node.nodeRight != nil{
            return true
        }
        return false
    }
    
    func isExternal(node:NodeRBT) -> Bool{
        if node.nodeRight == nil && node.nodeLeft == nil {
            return true
        }
        return false
    }
}