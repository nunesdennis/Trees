//
//  NodeRBT.swift
//  Trees
//
//  Created by Dennis da Silva Nunes on 26/01/16.
//
//

import UIKit

//Cor
// true = Rubro
// false = Preto

class NodeRBT:NSObject {
    var nodeFather:NodeRBT?
    var nodeLeft:NodeRBT?
    var nodeRight:NodeRBT?
    var key:Int
    var object:AnyObject
    var position:CGPoint?
    var cor:Bool
    
    init(key:Int,object:AnyObject,nodeFather:NodeRBT?,cor:Bool){
        self.key = key
        self.object = object
        self.nodeFather = nodeFather
        self.cor = cor
    }
}