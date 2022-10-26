defmodule Parser do
  def parse_file(filename) do
    # IO.puts("ENTROU PARSE_FILE")
    "reports/#{filename}"
    |> File.stream!()
    |> Stream.map(fn line -> parse_line(line) end)
  end

  def parse_line(line) do
    # IO.puts("ENTROU PARSE_LINE")
    line

    |> String.trim()
    |> String.split(",")

    # FUNÇÃO ANÔNIMA IMPLÍCITA COM & E /1
    |> List.update_at(2, &String.to_integer/1)
    # |> IO.inspect(label: "LINE")
  end
end
