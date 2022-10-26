defmodule ParserTest do
  use ExUnit.Case
  # alias Parser

  describe "parse_file/1" do
    # SETUP
    test "parse the file" do
      file_name = "report_test.csv"
      response = file_name
      |> Parser.parse_file()
      |> Enum.map(& &1)

      # EXERCISE
      expected_response = [
        ["1","pizza",48],
        ["2","açaí",45],
        ["3","hambúrguer",31],
        ["4","esfirra",42],
        ["5","hambúrguer",49],
        ["6","esfirra",18],
        ["7","pizza",27],
        ["8","esfirra",25],
        ["9","churrasco",24],
        ["10","churrasco",36]
      ]

      # ASSERTION
      assert response == expected_response
    end
  end

  describe "fetch_higher_cost/2" do
    test "when the test is 'users', returns the user who spent more" do
      file_name = "report_test.csv"
      response = file_name
      |> ReportsGenerator.start()
      |> ReportsGenerator.fetch_heigher_cost("users")

      expected_response = {:ok, {"5", 49}}
      assert response == expected_response
    end

    test "when the test is 'foods', returns the most consumed food" do
      file_name = "report_test.csv"
      response = file_name
      |> ReportsGenerator.start()
      |> ReportsGenerator.fetch_heigher_cost("foods")

      expected_response = {:ok, {"esfirra", 3}}
      assert response == expected_response
    end

    test "when an invalid option is given, returns an error" do
      file_name = "report_test.csv"
      response = file_name
      |> ReportsGenerator.start()
      |> ReportsGenerator.fetch_heigher_cost("bananas")

      expected_response = {:error, "Invalid Option"}
      assert response == expected_response
    end
  end

end
