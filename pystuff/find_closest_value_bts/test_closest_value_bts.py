from unittest import TestCase
from .closest_value_bts import BTS, closestValueBts


class ClosestBTSValueTest(TestCase):
    def testFindClosestValueGiven1Size(self):
        root = BTS(value=5, right=None, left=None)
        self.assertEqual(
            5,
            closestValueBts(root, 4),
        )

    def testFindClosestValueGiven2DeepthTree(self):
        root = BTS(value=5)
        left, right = BTS(value=2), BTS(value=10)
        root.left = left
        root.right = right
        self.assertEqual(
            2,
            closestValueBts(root, 3),
        )

    def testFindClosestValueGiven3DeepthTree(self):
        root = BTS(10,
                   left=BTS(5, left=BTS(2), right=BTS(5)),
                   right=BTS(15, left=BTS(13), right=BTS(22)))
        self.assertEqual(
            13,
            closestValueBts(root, 12),
        )
