from typing import Optional, Self


class BTS:
    def __init__(self, value: int, left: Optional[Self] = None, right: Optional[Self] = None):
        self.value = value
        self.left = left
        self.right = right


def closestValueBts(tree: BTS, target: int) -> int:
    closetValue = None

    def traverseTree(tree: Optional[BTS]):
        nonlocal closetValue
        if tree is None:
            return

        if closetValue is None:
            closetValue = tree.value
        elif abs(closetValue - target) > abs(tree.value - target):
            closetValue = tree.value

        traverseTree(tree.left)
        traverseTree(tree.right)

    traverseTree(tree)

    return closetValue
