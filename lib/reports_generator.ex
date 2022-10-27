defmodule ReportsGenerator do
  # USAR COMANDO "chcp 65001" NO VSCODE PARA UTF8 NO TERMINAL CASO NÃO ESTEJA

  @options [
    "foods",
    "users"
  ]

  @available_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  # ReportsGenerator.start("report_complete.csv")
  def start(file_name) do
    file_name
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), fn line, report ->
      sum_values(line, report)
    end)
  end

  defp report_acc do
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    start_report(foods, users)
  end

  defp sum_values([id, food_name, price], %{"foods" => foods, "users" => users}) do
    foods = Map.put(foods, food_name, foods[food_name] + 1)
    users = Map.put(users, id, users[id] + price)

    start_report(foods, users)
  end

  # FUNÇÃO DE SOBRECARGA PARA RECEBER PARÂMETROS COM VALORES DIFERENTES E TRATAR RETORNO
  def fetch_heigher_cost(report, option) when option in @options do
    {:ok, Enum.max_by(report[option], fn {_key, value} -> value end)}
  end

  def fetch_heigher_cost(_report, _option), do: {:error, "Invalid Option"}



  def start_from_many(file_names) do
    file_names
    # SINTAXE EXPLICITA
    |> Task.async_stream(fn file_name -> start(file_name) end)
    # SINTAXE IMPLICITA
    # > Task.async_stream(&start(/1))
    |> Enum.reduce(report_acc(), fn {:ok, result}, report -> sum_reports(report, result) end)
  end

  defp sum_reports(%{"foods" => foods1, "users" => users1}, %{"foods" => foods2, "users" => users2}) do
    users = merge_maps(users1, users2)
    foods = merge_maps(foods1, foods2)

    start_report(foods, users)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> value1 + value2 end)
  end

  defp start_report(foods, users), do: %{"foods" => foods, "users" => users}



end
