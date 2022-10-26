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
    # |> fetch_heigher_cost()
  end

  defp report_acc do
    # IO.puts("REPORT_ACC")
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    %{"users" => users, "foods" => foods}
  end

  defp sum_values([id, food_name, price], %{"foods" => foods, "users" => users} = report) do
    foods = Map.put(foods, food_name, foods[food_name] + 1)
    users = Map.put(users, id, users[id] + price)

    %{report | "users" => users, "foods" => foods}

    # report
    # |> Map.put("users", users)
    # |> Map.put("foods", foods)
  end

  # defp fetch_heigher_cost(report), do: Enum.max_by(report, fn {_key, value} -> value end)

  def fetch_heigher_cost(report, option) when option in @options do
    # IO.inspect(report, label: "HIGH")
    {:ok, Enum.max_by(report[option], fn {_key, value} -> value end)}
  end

  def fetch_heigher_cost(_report, _option), do: {:error, "Invalid Option"}

end
