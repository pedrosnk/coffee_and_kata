import unittest
from .sum_two_numbers import ListNode, Solution


class ListNodeTest(unittest.TestCase):
    def test_number_to_list(self):
        node = ListNode.number_to_list(123)
        self.assertEqual(node.val, 3)
        self.assertEqual(node.next.val, 2)
        self.assertEqual(node.next.next.val, 1)

    def test_to_integer(self):
        node = ListNode.number_to_list(123)
        self.assertEqual(node.to_integer(), 123)

        node = ListNode.number_to_list(5648)
        self.assertEqual(node.to_integer(), 5648)


class SolutionTest(unittest.TestCase):
    def test_add_two_numbers(self):
        l1 = ListNode.number_to_list(243)
        l2 = ListNode.number_to_list(564)
        result = Solution().addTwoNumbers(l1, l2)

        self.assertEqual(result.to_integer(), 807)

        l1 = ListNode.number_to_list(0)
        l2 = ListNode.number_to_list(0)
        result = Solution().addTwoNumbers(l1, l2)

        self.assertEqual(result.to_integer(), 0)

        l1 = ListNode.number_to_list(50)
        l2 = ListNode.number_to_list(60)
        result = Solution().addTwoNumbers(l1, l2)

        self.assertEqual(result.to_integer(), 110)

    def test_add_two_numbers_differnt_lenghs(self):
        l1 = ListNode.number_to_list(5)
        l2 = ListNode.number_to_list(16)
        result = Solution().addTwoNumbers(l1, l2)

        self.assertEqual(result.to_integer(), 21)
