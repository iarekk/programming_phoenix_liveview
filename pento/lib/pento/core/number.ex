defmodule Pento.Core.Number do
  @moduledoc """
  As often as pos- sible, experienced Elixir developers strive to make a module’s public functions relate to its core type.
  Taken together, we’ll call this pattern “CRC”, which stands for “Construct, Reduce, Convert”.
  """

  @doc """
  Construct.

  Constructors create a term of the core type from conve- nient inputs.
  """
  def new(string), do: string |> String.to_integer()

  @doc """
  Reduce.
  Reducers transform a term of the core type to another term of that type.
  """
  def add(number, added), do: number + added

  @doc """
  Convert.
  Converters convert the core type to some other type.
  """
  def to_string(number), do: Integer.to_string(number)
end
