# https://adventofcode.com/2023/day/2
defmodule Cube do
  def run(input_file, part) do
    File.stream!(input_file)
    |> Enum.map(part)
    |> Enum.sum()
  end

  def valid_game_id(game) do
    {id, draws} = parse_game(game)

    valid_draw = parse_draws(draws)
      |> Enum.map(fn draw ->
        parse_draw(draw)
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
      true -> String.to_integer(id)
      _ -> 0 # since we're summing, just return 0 if not valid
    end
  end

  # Part 2: Sum of powers of minimum cubes needed
  def power_of_cubes(game) do
    {_, draws} = parse_game(game)

    parse_draws(draws)
    |> Enum.reduce(
      %{"red" => 0, "green" => 0, "blue" => 0},
      fn draw, acc ->
        parse_draw(draw)
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
  end

  defp parse_game(game) do
    ["Game " <> id, draws] = String.split(game, ":")
    {id, draws}
  end

  defp parse_draws(draws) do
    draws
    |> String.trim()
    |> String.split(";")
  end

  defp parse_draw(draw) do
    draw
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&parse_pick/1)
  end

  defp parse_pick(pick) do
    [n, color] = pick |> String.trim() |> String.split(" ")
    {color, String.to_integer(n)}
  end
end

"Part 1: #{Cube.run("2.txt", &Cube.valid_game_id/1)}"
|> IO.puts

"Part 2: #{Cube.run("2.txt", &Cube.power_of_cubes/1)}"
|> IO.puts
