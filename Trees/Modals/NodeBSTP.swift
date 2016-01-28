//
//  nodeBSTP.swift
//  AVLTree
//
//  Created by Dennis da Silva Nunes on 20/10/15.
//
//

import UIKit

public protocol NodeBSTP{

    var nodeFather:NodeBSTP?{get set}
    var nodeLeft:NodeBSTP?{get set}
    var nodeRight:NodeBSTP?{get set}
    var key:Int!{get set}
    var object:AnyObject!{get set}
    
}