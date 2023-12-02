# https://adventofcode.com/2023/day/1
defmodule Trebuchet do
  def solve(input_file) do
    File.stream!(input_file)
    |> Enum.map(&calibrate!/1)
    |> Enum.sum()
  end

  defp calibrate!(line) do
    digits = line
      |> String.trim()
      |> extract()

    List.first(digits) <> List.last(digits)
    |> String.to_integer
  end

  defp extract(""), do: []
  defp extract("one" <> _ = s = s), do: ["1"] ++ advance(s)
  defp extract("1" <> _ = s), do: ["1"] ++ advance(s)
  defp extract("two" <> _ = s), do: ["2"] ++ advance(s)
  defp extract("2" <> _ = s), do: ["2"] ++ advance(s)
  defp extract("three" <> _ = s), do: ["3"] ++ advance(s)
  defp extract("3" <> _ = s), do: ["3"] ++ advance(s)
  defp extract("four" <> _ = s), do: ["4"] ++ advance(s)
  defp extract("4" <> _ = s), do: ["4"] ++ advance(s)
  defp extract("five" <> _ = s), do: ["5"] ++ advance(s)
  defp extract("5" <> _ = s), do: ["5"] ++ advance(s)
  defp extract("six" <> _ = s), do: ["6"] ++ advance(s)
  defp extract("6" <> _ = s), do: ["6"] ++ advance(s)
  defp extract("seven" <> _ = s), do: ["7"] ++ advance(s)
  defp extract("7" <> _ = s), do: ["7"] ++ advance(s)
  defp extract("eight" <> _ = s), do: ["8"] ++ advance(s)
  defp extract("8" <> _ = s), do: ["8"] ++ advance(s)
  defp extract("nine" <> _ = s), do: ["9"] ++ advance(s)
  defp extract("9" <> _ = s), do: ["9"] ++ advance(s)
  defp extract(s), do: advance(s)

  defp advance(s), do: s |> String.slice(1..-1) |> extract()
end

"Part 2: #{Trebuchet.solve("1.txt")}" |> IO.puts
