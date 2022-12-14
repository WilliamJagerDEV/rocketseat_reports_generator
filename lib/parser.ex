defmodule Parser do
  def parse_file(filename) do
    "reports/#{filename}"
    |> File.stream!()
    |> Stream.map(fn line -> parse_line(line) end)
  end

  def parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")

    # FUNÇÃO ANÔNIMA IMPLÍCITA COM &(chamando uma função como o fn) E /1(primeiro argumento)
    |> List.update_at(2, &String.to_integer/1)
  end
end
