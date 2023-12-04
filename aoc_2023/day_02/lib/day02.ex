defmodule Day02 do
  @possible_bags %{
    red: 12,
    green: 13,
    blue: 14
  }

  @spec part1_from_file() :: pos_integer()
  def part1_from_file() do
    File.read!("#{__DIR__}/../priv/input.txt")
    |> part1()
  end

  @spec part1(input :: String.t()) :: pos_integer()
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Stream.map(&String.split(&1, ":"))
    |> Stream.filter(fn [_game, line] ->
      String.split(line, ";", trim: true)
      |> Enum.all?(&possible?/1)
    end)
    |> Stream.map(fn [game, _] ->
      "Game " <> n = game
      String.to_integer(n)
    end)
    |> Enum.sum()
  end

  @spec possible?(match :: String.t()) :: boolean()
  def possible?(match) do
    match
    |> String.split(",", trim: true)
    |> Enum.all?(fn draw ->
      draw
      |> String.trim()
      |> Integer.parse()
      |> case do
        {n, " blue"} ->
          n <= @possible_bags.blue

        {n, " green"} ->
          n <= @possible_bags.green

        {n, " red"} ->
          n <= @possible_bags.red
      end
    end)
  end

  @spec part2(input :: String.t()) :: pos_integer()
  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Stream.map(fn line ->
      line
      |> String.split(":")
      |> Enum.at(1)
      |> String.split(";")
      |> find_min_values()
    end)
    |> Enum.map(&Enum.product/1)
    |> Enum.sum()
  end

  @spec find_min_values(matches :: list(String.t()), acc :: map()) :: list(pos_integer)

  def find_min_values(matches, acc \\ %{})

  def find_min_values([], acc), do: Map.values(acc)

  def find_min_values([match | rest], acc) do
    min_values =
      match
      |> String.split(",")
      |> Stream.map(fn m -> m |> String.trim() |> Integer.parse() end)
      |> Enum.reduce(acc, fn {number, color}, acc ->
        Map.update(acc, color, number, fn
          n when n < number -> number
          n -> n
        end)
      end)

    find_min_values(rest, min_values)
  end

  @spec part2_from_file() :: pos_integer()
  def part2_from_file() do
    File.read!("#{__DIR__}/../priv/input.txt")
    |> part2()
  end
end
