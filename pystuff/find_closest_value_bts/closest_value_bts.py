from typing import Optional, Self


class BTS:
    def __init__(self, value: int, left: Optional[Self] = None, right: Optional[Self] = None):
        self.value = value
        self.left = left
        self.right = right


def closestValueBts(tree: BTS, target: int) -> int:
    closestValue = None

    def traverseTree(tree: Optional[BTS]):
        nonlocal closestValue
        if tree is None:
            return

        if closestValue is None:
            closestValue = tree.value
        elif abs(closestValue - target) > abs(tree.value - target):
            closestValue = tree.value

        traverseTree(tree.left)
        traverseTree(tree.right)

    traverseTree(tree)

    return closestValue
