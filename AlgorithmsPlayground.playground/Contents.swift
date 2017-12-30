import UIKit

//MARK: Data Structures for both algorithms
class ListNode {
    var value:Int!
    var next:ListNode?
    
    init(next:ListNode?, value:Int) {
        self.next = next
        self.value = value
    }
}

class TreeNode {
    var value:Int!
    var leftChild:TreeNode?
    var rightChild:TreeNode?
    
    init(leftChild:TreeNode?, rightChild:TreeNode?, value:Int) {
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.value = value
    }
    
}

// MARK: LinkedList Helper Methods
func stepOnce(node: inout ListNode) -> Bool {
    if(node.next != nil) {
        node = node.next!
        return true
    } else {
        return false
    }
}

func stepTwice(node: inout ListNode) -> Bool {
    if(node.next != nil && node.next!.next != nil) {
        node = node.next!.next!
        return true
    } else {
        return false
    }
}

//MARK Algoritm Implementations

/*******************************Circular Linked List Finder*********************************
 *
 *      The method creates 2 Iterator nodes starting from head, one nodes travels 1 node at a time whereas the other node travels 2 nodes.
 *      There are two conditions to terminate: Firstly, if either one is on a node that has a null next value that means that the list is non-circular
 *      Other condition is the list is circular and to iterator nodes have to cross somewhere on the list. When they meet that means that the list is 100% circular
 *
 *******************************************************************************************/
func isLinkedListCircular(head:ListNode) -> Bool {
    
    if(head.value == nil) {
        return true
    } else {
        var firstIterator:ListNode = head
        var secondIterator:ListNode = head
        stepOnce(node: &firstIterator)
        stepTwice(node: &secondIterator)
        print("First Iterator: \(firstIterator.value)")
        print("Second Iterator: \(secondIterator.value)")
        print("****************")
        while(firstIterator.next != nil && secondIterator.next != nil) {
            stepOnce(node: &firstIterator)
            stepTwice(node: &secondIterator)
            print("First Iterator: \(firstIterator.value)")
            print("Second Iterator: \(secondIterator.value)")
            print("****************")
            if(firstIterator.value == secondIterator.value) {
                print("Bingo! Circular Linked List Found!")
                print("/////////////////////////////////")
                return true
            }
        }
        print("Pfffs, That's A Non-Circular Linked List")
        print("////////////////////////////////////////")
        return false
    }
}

/*******************************Binary Search Tree Finder***********************************
 *
 *      The method takes the head of the Binary Search Tree and checks the if the value is right according to BST Algorithm that is the value of the left child has to be smaller than
 *      the head and the value of the right child has to be bigger. Following this rule, the method starts with the value of head node and looks if it is between min integer and max integer.
 *      After that it recursively checks all left and right childs by narrowing the minimum and maximum values. When calling the method on a left child, the rule is that the value of the
 *      head is the new maximum value because a left child's value can't be bigger than the parent value. Similarly when calling the method on right childs, the minimum value is set the
 *      head's value because the right child's value can't be smaller than the head value. If this condition is not met, the method returns false, otherwise the methods gets called until
 *      the head value is null and returns true since the condition is met everytime the method is called until it reaches the bottom of the tree.
 *
 *******************************************************************************************/
func isBinarySearchTree(head:TreeNode?, minVal:Int, maxVal:Int) -> Bool {
    
    if(head == nil) {
        return true
    }
    print("Head Value: \(head!.value)")
    print("Min Value: \(minVal)")
    print("Max Value: \(maxVal)")
    print("--------------------")
    
    if(head!.value < minVal || head!.value > maxVal) {
        print("That Is Not A BST, Sorry:(")
        return false
    }
    return isBinarySearchTree(head: head!.rightChild, minVal: head!.value, maxVal: maxVal) && isBinarySearchTree(head: head!.leftChild, minVal: minVal, maxVal: head!.value)
}


//MARK: LinkedList Test Method
func testWithCircularLinkedListData(isCircular:Bool) {
    
    var nodesArray = [ListNode]()
    
    let node1 = ListNode(next: nil, value: 1)
    nodesArray.append(node1)
    let node2 = ListNode(next: nil, value: 8)
    nodesArray.append(node2)
    let node3 = ListNode(next: nil, value: 56)
    nodesArray.append(node3)
    let node4 = ListNode(next: nil, value: 122)
    nodesArray.append(node4)
    let node5 = ListNode(next: nil, value: 155)
    nodesArray.append(node5)
    let node6 = ListNode(next: nil, value: 172)
    nodesArray.append(node6)
    let node7 = ListNode(next: nil, value: 199)
    nodesArray.append(node7)
    
    node1.next = node2
    node2.next = node3
    node3.next = node4
    node4.next = node5
    node5.next = node6
    node6.next = node7
    if(isCircular){
        node6.next = nodesArray[Int(arc4random_uniform(UInt32(nodesArray.count)))]
    } else {
        node7.next = nil
    }
    
    isLinkedListCircular(head: node1)
}

//MARK: Binary Search Tree Test Method
func testWithBinarySearchTreeData(isBST:Bool) {
    
    let node7 = TreeNode(leftChild: nil, rightChild: nil, value: 85)
    let node6 = TreeNode(leftChild: nil, rightChild: nil, value: 36)
    let node5 = TreeNode(leftChild: nil, rightChild: nil, value: 26)
    let node4 = TreeNode(leftChild: nil, rightChild: nil, value: 18)
    let node3 = TreeNode(leftChild: node6, rightChild: node7, value: 43)
    let node2 = TreeNode(leftChild: node4, rightChild: node5, value: 24)
    let node1:TreeNode
    if(isBST) {
        node1 = TreeNode(leftChild: node2, rightChild: node3, value: 32)
    } else {
        node1 = TreeNode(leftChild: node2, rightChild: node3, value: 10)
    }
    
    let flag = isBinarySearchTree(head: node1, minVal: Int.min, maxVal: Int.max)
    if(flag) {
        print("There Is A Perfect BST Here!")
    }
}

//MARK: Test method calls here
//Boolean flags can be set to test methods, true flags return a true test dataset whereas false flag returns a non-circular linked list and a wrong binary search tree to methods, respectively.
testWithCircularLinkedListData(isCircular:true)
testWithBinarySearchTreeData(isBST: true)
