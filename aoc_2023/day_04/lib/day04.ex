defmodule Day04 do
  def part1_from_file() do
    File.read!("#{__DIR__}/../priv/input.txt") |> part1()
  end

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(~r/:|\|/)
      |> tl()
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> then(fn [cards, game] -> game -- game -- cards end)
      |> then(fn
        [] -> 0
        cards -> 2 ** (Enum.count(cards) - 1)
      end)
    end)
    |> Enum.sum()
  end

  def part2_from_file() do
    File.read!("#{__DIR__}/../priv/input.txt") |> part2()
  end

  def part2(input) do
    cards_with_wins =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {line, index} ->
        card_n = index + 1

        card_wins =
          line
          |> String.split(~r/:|\|/)
          |> tl()
          |> Enum.map(&String.split(&1, " ", trim: true))
          |> then(fn [cards, game] -> Enum.count(game -- game -- cards) end)

        {card_n, card_wins}
      end)

    n_copied_cards =
      Enum.reduce(cards_with_wins, %{}, fn
        {_card_n, 0}, cards_copied ->
          cards_copied

        {card_n, wins}, cards_copied ->
          copies = Map.get(cards_copied, card_n, 0)

          for _ <- 0..copies, n <- (card_n + 1)..(card_n + wins), reduce: cards_copied do
            cards_copied -> Map.update(cards_copied, n, 1, &(&1 + 1))
          end
      end)
      |> Map.values()
      |> Enum.sum()

    Enum.count(cards_with_wins) + n_copied_cards
  end
end
