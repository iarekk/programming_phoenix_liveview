defmodule Pento.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias Phoenix.LiveViewTest.Element
  alias Pento.Repo

  alias Pento.Catalog.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  def markdown_product(%Product{unit_price: current_price} = product, price_decrease) do
    new_price = current_price - get_as_decimal!(price_decrease |> IO.inspect(label: "GAD-pre"))
    attrs = %{unit_price: new_price, markdown_product: true}

    Product.changeset(product, attrs)
    |> Repo.update()
  end

  def add_discount(%Product{unit_price: current_price} = product, discount_rate)
      when discount_rate > 0.0 and discount_rate < 1.0 do
    product |> Map.put(:markdown_amount, current_price * discount_rate)
  end

  def get_as_decimal!(s) when is_binary(s), do: Float.parse(s) |> elem(0)
  def get_as_decimal!(f) when is_float(f), do: f
  def get_as_decimal!(any), do: raise("Bad any #{inspect(any)}")
end
