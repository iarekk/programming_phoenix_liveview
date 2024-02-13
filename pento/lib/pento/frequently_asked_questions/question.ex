defmodule Pento.FrequentlyAskedQuestions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :question, :string
    field :answer, :string, default: nil
    field :votes, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question, :answer, :votes])
    |> validate_required([:question])
  end
end
