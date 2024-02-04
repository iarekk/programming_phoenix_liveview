defmodule Pento.Core.NumberTest do
  alias Pento.Core.Number, as: Number

  use ExUnit.Case

  test "demo the CRC pattern with Enum.reduce/3" do
    list = [1, 2, 3]
    total = Number.new("0")

    reducer = &Number.add(&2, &1)

    converter = &Number.to_string(&1)

    assert "6" == Enum.reduce(list, total, reducer) |> converter.()
  end

  test "demo CRC pattern with pipes" do
    [first, second, third] = [1, 2, 3]

    result =
      "0"
      |> Number.new()
      |> Number.add(first)
      |> Number.add(second)
      |> Number.add(third)
      |> Number.to_string()

    assert "6" = result
  end
end
