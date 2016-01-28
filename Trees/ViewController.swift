//
//  ViewController.swift
//  Trees
//
//  Created by Dennis da Silva Nunes on 08/11/15.
//
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var treeView: TreeView!
    @IBOutlet weak var textField: UITextField!
    var tree:RBTree?
    var elements:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.BlackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Adicionar", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
        
        let items = NSMutableArray()
        items.addObject(flexSpace)
        items.addObject(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.textField.inputAccessoryView = doneToolbar
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        doneButtonAction()
        return true
    }
    func doneButtonAction()
    {
        textField.resignFirstResponder()
        if textField.text != "" {
            if let num = Int(textField.text!){
                if tree == nil {
                    elements.append(num)
                    tree = RBTree(rootKey: num, rootObject: createObject(num))
                }else{
                    elements.append(num)
                    tree = criarArvore(elements)
                }
                updateTreeView(tree!)
                self.view.bringSubviewToFront(textField)
            }
        }
        textField.text = ""
    }
    
    func createObject(key:Int)->String{
        return "Objeto \(key)"
    }
    
    func criarArvore(numeros:[Int])-> RBTree{
        let arvoreRN = RBTree(rootKey: numeros[0], rootObject: createObject(numeros[0]))
        
        for num in numeros {
            if num == numeros[0]{continue}
            arvoreRN.add(num, object: createObject(num))
        }
        return arvoreRN
    }
    
    func impressoes(arvore:RBTree){
        print("//Em ordem //")
        arvore.printInOrder()
        print("//Pós ordem //")
        arvore.printPostOrder()
        print("//Pré ordem //")
        arvore.printPreOrder()
    }
    func updateTreeView(tree:RBTree){
        let frame = CGRectMake(0, 0, self.view.window!.frame.width,self.view.window!.frame.height)
        let example = TreeView(frame: frame)
        example.backgroundColor = UIColor(red: 119/255, green: 235/255, blue: 228/255, alpha: 1.0)
        example.tree = tree
        example.setNeedsDisplay()
        treeView = example
        self.view.addSubview(treeView)
    }
}

