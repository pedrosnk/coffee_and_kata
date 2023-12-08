defmodule Day05 do
  def part1_from_file do
    File.read!("#{__DIR__}/../priv/input.txt")
    |> part1()
  end

  def part1(input) do
    input
    |> parse_almanac()
    |> find_lowest_location_seed()
  end

  def part2_from_file do
    File.read!("#{__DIR__}/../priv/input.txt")
    |> part2()
  end

  def part2(input) do
    almanac = Day05.parse_almanac(input)

    almanac.seeds
    |> Enum.chunk_every(2)
    |> Enum.map(fn [start, size] ->
      Task.async(fn ->
        seeds = Enum.to_list(start..(start + size - 1))
        almanac = %{almanac | seeds: seeds}

        find_lowest_location_seed(almanac)
      end)
    end)
    |> Task.await_many(:infinity)
    |> Enum.min()
  end

  def find_lowest_location_seed(almanac) do
    almanac.seeds
    |> Enum.reduce(:infinity, fn seed, acc ->
      dest_loc =
        almanac.maps
        |> Enum.reduce(seed, fn %{locations: locations}, seed_loc ->
          locations
          |> Enum.find(fn [_dest, source, range] ->
            seed_loc in source..(source + range - 1)
          end)
          |> case do
            [dest, source, _range] ->
              dest + seed_loc - source

            nil ->
              seed_loc
          end
        end)

      case acc do
        n when n > dest_loc -> dest_loc
        :infinity -> dest_loc
        _ -> acc
      end
    end)
  end

  def parse_almanac(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.reduce(%{}, fn
      "seeds: " <> str, acc ->
        seeds =
          str
          |> String.split(" ", trim: true)
          |> Enum.map(&String.to_integer/1)

        Map.put(acc, :seeds, seeds)

      str, acc ->
        [name | locations] =
          str
          |> String.split("\n", trim: true)

        locations =
          locations
          |> Enum.map(fn line ->
            line
            |> String.split(" ", trim: true)
            |> Enum.map(&String.to_integer/1)
          end)

        map = %{name: name, locations: locations}
        Map.update(acc, :maps, [map], &(&1 ++ [map]))
    end)
  end
end
