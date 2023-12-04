defmodule Day01 do
  @spec part1_from_file() :: pos_integer()
  def part1_from_file() do
    File.read!("#{__DIR__}/../priv/input.txt")
    |> part1()
  end

  @spec part2_from_file() :: pos_integer()
  def part2_from_file() do
    File.read!("#{__DIR__}/../priv/input.txt")
    |> part2()
  end

  @spec part1(input :: String.t()) :: pos_integer()
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      numbers =
        line
        |> String.graphemes()
        |> Enum.map(fn c ->
          case Integer.parse(c) do
            :error -> nil
            {n, ""} -> n
          end
        end)
        |> Enum.filter(&(&1 != nil))

      line_number =
        case numbers do
          [n] ->
            n * 10 + n

          nums ->
            List.first(nums) * 10 + List.last(nums)
        end

      acc + line_number
    end)
  end

  @spec part2(input :: Stirng.t()) :: pos_integer()
  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      value = 10 * first_digit(line) + last_digit(String.reverse(line))
      acc + value
    end)
  end

  digits = 1..9

  @spec first_digit(String.t()) :: pos_integer()
  defp first_digit(line)

  @spec last_digit(String.t()) :: pos_integer()
  defp last_digit(line)

  for i <- digits do
    s = Integer.to_string(i)
    defp first_digit(unquote(s) <> _rest), do: unquote(i)
    defp last_digit(unquote(s) <> _rest), do: unquote(i)
  end

  words = [
    {1, "one"},
    {2, "two"},
    {3, "three"},
    {4, "four"},
    {5, "five"},
    {6, "six"},
    {7, "seven"},
    {8, "eight"},
    {9, "nine"}
  ]

  for {number, word} <- words do
    reversed_word = String.reverse(word)
    defp first_digit(unquote(word) <> _rest), do: unquote(number)
    defp last_digit(unquote(reversed_word) <> _rest), do: unquote(number)
  end

  defp first_digit(<<_::utf8, rest::binary>>), do: first_digit(rest)
  defp last_digit(<<_::utf8, rest::binary>>), do: last_digit(rest)
end
