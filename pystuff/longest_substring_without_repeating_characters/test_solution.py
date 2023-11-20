from unittest import TestCase
from .solution import Solution


class SolutionTest(TestCase):
    def test_non_repeating_string(self):
        self.assertEqual(
            Solution().lengthOfLongestSubstring('a'),
            1,
        )

        self.assertEqual(
            Solution().lengthOfLongestSubstring('abc'),
            3,
        )

    def test_repeating_string(self):
        self.assertEqual(
            Solution().lengthOfLongestSubstring('aba'),
            2,
        )

    def test_examples(self):
        self.assertEqual(
            Solution().lengthOfLongestSubstring('abcabcbb'),
            3,
        )

        self.assertEqual(
            Solution().lengthOfLongestSubstring('bbbbb'),
            1,
        )

        self.assertEqual(
            Solution().lengthOfLongestSubstring('pwwkew'),
            3,
        )
