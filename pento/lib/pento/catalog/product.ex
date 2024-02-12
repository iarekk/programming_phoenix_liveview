defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :description, :string
    field :unit_price, :float
    field :sku, :integer

    timestamps()
  end

  def changeset(product, %{unit_price: _, mark_down_product: true} = attrs) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_required([:unit_price])
    |> validate_number(:unit_price, greater_than: 0.0, message: "Prices must be positive.")
    |> validate_number(:unit_price,
      less_than: product.unit_price,
      message: "Prices can only decrease."
    )
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku, message: "SKUs must be unique")
    |> validate_number(:unit_price, greater_than: 0.0, message: "Prices must be positive.")
  end
end
