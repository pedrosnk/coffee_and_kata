class Solution():
    def lengthOfLongestSubstring(self, s: str) -> int:
        prevStreakStart = 0
        longestStreak = 0
        charsDict = {}

        for i in range(len(s)):
            prevCharLocation = charsDict.get(s[i])

            if prevCharLocation is not None and \
                    prevCharLocation >= prevStreakStart:

                prevStreakStart = prevCharLocation + 1

            charsDict[s[i]] = i
            currStreak = i + 1 - prevStreakStart

            if currStreak > longestStreak:
                longestStreak = currStreak

        return longestStreak
