//
//  treeAVLTP.swift
//  AVLTree
//
//  Created by Dennis da Silva Nunes on 20/10/15.
//
//
// AVL tree protocol
import UIKit

public protocol AVLTreeP:BSTreeP{

    func rotateLeft(node:NodeAVLTP)
    
    func doubleRotateLeft(node:NodeAVLTP)
    
    func rotateRight(node:NodeAVLTP)
    
    func doubleRotateRight(node:NodeAVLTP)
    
}
