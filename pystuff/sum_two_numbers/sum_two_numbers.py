class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

    def number_to_list(number=int):
        root = None
        currentNode = None
        for n in reversed(str(number)):
            node = ListNode(val=int(n))
            if currentNode:
                currentNode.next = node

            if root is None:
                root = node

            currentNode = node

        return root

    def to_integer(self) -> int:
        node = self
        numbers = []
        while node is not None:
            numbers.insert(0, str(node.val))
            node = node.next

        return int(''.join(numbers))


class Solution:
    def addTwoNumbers(self, l1=None, l2=None):
        # quick sollution
        # return ListNode.number_to_list(l1.to_integer() + l2.to_integer())

        remainer = 0
        root = None
        currentNode = None

        while l1 or l2:
            sum = remainer

            if l1:
                sum += l1.val
                l1 = l1.next

            if l2:
                sum += l2.val
                l2 = l2.next

            remainer, val = divmod(sum, 10)
            node = ListNode(val=val)

            if currentNode:
                currentNode.next = node

            if root is None:
                root = node

            currentNode = node

        if remainer != 0:
            currentNode.next = ListNode(val=remainer)

        return root
