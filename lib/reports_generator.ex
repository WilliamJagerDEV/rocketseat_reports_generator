defmodule ReportsGenerator do
  # USAR COMANDO "chcp 65001" NO VSCODE PARA UTF8 NO TERMINAL CASO NÃO ESTEJA

  # ===========================================================
  def build(filename) do
    # CASE MODE
    # case file = File.read("reports/#{filename}") do
    #   {:ok, result} -> result
    #   {:error, reason} -> reason
    # end

    # PIPE & OVERLOAD MODE
    "reports/#{filename}"
    |> File.read()
    |> handle_file("Arquivo: ")
  end

  # def handle_file({:ok, result}, msg), do: msg <> result
  def handle_file({:ok, result}, msg) do
    msg <> result
  end

  # def handle_file({:error, reason}, msg), do: msg <> "erro: " <> reason
  def handle_file({:error, reason}, msg) do
    msg <> "erro: " <> "#{reason}"
  end

  # ===========================================================

  # ReportsGenerator.start("report_complete.csv")
  def start(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report ->
      sum_values(line, report)
    end)
    |> fetch_heigher_cost()
  end

  defp report_acc, do: Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

  defp sum_values([id, _food_name, price], report), do: Map.put(report, id, report[id] + price)

  defp fetch_heigher_cost(report), do: Enum.max_by(report, fn {_key, value} -> value end)

end
