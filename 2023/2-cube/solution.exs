# https://adventofcode.com/2023/day/2
defmodule Cube do

  def run(input_file, part) do
    File.stream!(input_file)
    |> Enum.map(part)
    |> Enum.sum()
  end

  # Find valid games
  def part_1(game) do
    {id, draws} = game_draws(game)

    valid_draw = extract_draw(draws)
      |> Enum.map(fn draw ->
        extract_picks(draw)
        |> Enum.map(fn
          {"red", n} when n > 12 -> false
          {"green", n} when n > 13 -> false
          {"blue", n} when n > 14 -> false
          _ -> true
        end)
        |> Enum.all?()
      end)
      |> Enum.all?()

    case valid_draw do
      true ->
        {val, _} = Integer.parse(id)
        val
      _ -> 0
    end
  end

  # Sum of powers of minimum cubes needed
  def part_2(game) do
    {id, draws} = game_draws(game)

    power = extract_draw(draws)
      |> Enum.reduce(
        %{"red" => 0, "green" => 0, "blue" => 0},
        fn draw, acc ->
          extract_picks(draw)
          |> Enum.reduce(acc, fn ({color, n}, acc) ->
            {_, acc} = Map.get_and_update(acc, color, fn
                current when n > current -> {current, n}
                current -> {current, current}
              end)

            acc
          end)
        end
      )
      |> Map.values()
      |> Enum.product()

    power
  end

  defp game_draws(game) do
    ["Game " <> id, draws] = game
      |> String.split(":")
     {id, draws}
  end

  defp extract_draw(draws) do
    draws
    |> String.trim()
    |> String.split(";")
  end

  defp extract_picks(draw) do
    draw
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&extract_pick/1)
  end

  defp extract_pick(pick) do
    [n, color] = pick |> String.trim() |> String.split(" ")
    {parsed, _} = Integer.parse(n)
    {color, parsed}
  end
end
