defmodule ReportsGenerator do
  @moduledoc """
  Documentation for `ReportsGenerator`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ReportsGenerator.build("report_test.csv")
      :world

  """

  # USAR COMANDO "chcp 65001" NO VSCODE PARA UTF8 NO TERMINAL CASO NÃO ESTEJA

  # ===========================================================
  def build(filename) do
    # CASE MODE
    # case file = File.read("reports/#{filename}") do
    #   {:ok, result} -> result
    #   {:error, reason} -> reason
    # end

    #PIPE & OVERLOAD MODE
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

  # ReportsGenerator.start("report_test.csv")
  def start(filename) do
    "reports/#{filename}"
    |> File.stream!()
    # |> Enum.each(fn line -> IO.inspect(line) end)
    |> Enum.map(fn line -> parse_line(line) end)
  end

  def parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    # FUNÇÃO ANÔNIMA IMPLÍCITA COM & E /1
    |> List.update_at(2, &String.to_integer/1)
  end




end
