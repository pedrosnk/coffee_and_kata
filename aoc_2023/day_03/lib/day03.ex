defmodule Day03 do
  def part1_from_file do
    input = File.read!("#{__DIR__}/../priv/input.txt")
    part1(input)
  end

  @spec part1(input :: String.t()) :: pos_integer()
  def part1(input) do
    matrix =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split("", trim: true)
      end)

    matrix
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_id} ->
      extract_numbers(row)
      |> Enum.filter(fn number ->
        Enum.any?(number.range, fn x ->
          has_adjacent_symbol?(matrix, row_id, x)
        end)
      end)
      |> Enum.map(& &1.value)
    end)
    |> Enum.sum()
  end

  def part2_from_file do
    input = File.read!("#{__DIR__}/../priv/input.txt")
    part2(input)
  end

  def part2(input) do
    matrix =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split("", trim: true)
      end)

    numbers =
      matrix
      |> Enum.with_index()
      |> Enum.flat_map(fn {row, row_id} ->
        extract_numbers(row)
        |> Enum.map(&put_in(&1, [:row_id], row_id))
        |> Enum.map(&add_starts_to_number(&1, matrix))
      end)

    Enum.reduce(numbers, %{}, fn number, acc ->
      for coord <- number.stars, reduce: acc do
        acc ->
          Map.update(acc, coord, [number.value], &[number.value | &1])
      end
    end)
    |> Enum.filter(fn {_, numbers} -> length(numbers) >= 2 end)
    |> Enum.map(fn {_, numbers} ->
      numbers |> Enum.product()
    end)
    |> Enum.sum()
  end

  # extract_numbers("..23..2")
  # > [%{value: 23, range: 2..3}, %{value: 2, range: 6..6}]
  def extract_numbers(row, cur_col_id \\ 0, numbers \\ [])

  def extract_numbers([], _, numbers), do: Enum.reverse(numbers)

  def extract_numbers([<<c::utf8>> | rest], cur_col_id, numbers) when c in ?0..?9 do
    {rest, cur_col_id, number} = extract_number(rest, cur_col_id + 1, <<c>>)
    extract_numbers(rest, cur_col_id + 1, [number | numbers])
  end

  def extract_numbers([_ | rest], cur_col_id, numbers) do
    extract_numbers(rest, cur_col_id + 1, numbers)
  end

  def extract_number(row, cur_col_id, acc \\ "")

  def extract_number([], cur_col_id, acc) do
    value = String.to_integer(acc)
    range = Range.new(cur_col_id - String.length(acc), cur_col_id - 1)
    {[], cur_col_id, %{value: value, range: range}}
  end

  def extract_number([<<c::utf8>> | rest], cur_col_id, acc) when c not in ?0..?9 do
    value = String.to_integer(acc)
    range = Range.new(cur_col_id - String.length(acc), cur_col_id - 1)
    {rest, cur_col_id, %{value: value, range: range}}
  end

  def extract_number([<<c::utf8>> | rest], cur_col_id, acc) when c in ?0..?9 do
    extract_number(rest, cur_col_id + 1, acc <> <<c>>)
  end

  def has_adjacent_symbol?(matrix, column, row) do
    n_rows = length(matrix)
    n_columns = length(Enum.at(matrix, 0))
    range_x = Range.new(column - 1, column + 1)
    range_y = Range.new(row - 1, row + 1)

    adjacent_positions =
      for x <- range_x,
          y <- range_y,
          x != column or y != row,
          x >= 0,
          y >= 0,
          x < n_columns,
          y < n_rows,
          do: {x, y}

    adjacent_positions
    |> Enum.any?(fn {x, y} ->
      matrix
      |> Enum.at(x)
      |> Enum.at(y)
      |> case do
        "." -> false
        <<c::utf8>> when c in ?0..?9 -> false
        _ -> true
      end
    end)
  end

  def add_starts_to_number(number, matrix) do
    stars =
      for x <- number.range do
        adjacent_stars(matrix, number.row_id, x)
      end
      |> List.flatten()
      |> Enum.uniq()

    put_in(number, [:stars], stars)
  end

  def adjacent_stars(matrix, column, row) do
    n_rows = length(matrix)
    n_columns = length(Enum.at(matrix, 0))
    range_x = Range.new(column - 1, column + 1)
    range_y = Range.new(row - 1, row + 1)

    adjacent_positions =
      for x <- range_x,
          y <- range_y,
          x != column or y != row,
          x >= 0,
          y >= 0,
          x < n_columns,
          y < n_rows,
          do: {x, y}

    adjacent_positions
    |> Enum.map(fn {x, y} ->
      matrix
      |> Enum.at(x)
      |> Enum.at(y)
      |> case do
        "*" -> {x, y}
        _ -> nil
      end
    end)
    |> Enum.filter(&(&1 != nil))
  end
end
