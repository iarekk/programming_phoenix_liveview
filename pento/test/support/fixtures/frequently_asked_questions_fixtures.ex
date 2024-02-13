defmodule Pento.FrequentlyAskedQuestionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.FrequentlyAskedQuestions` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        question: "some question",
        votes: 42
      })
      |> Pento.FrequentlyAskedQuestions.create_question()

    question
  end
end
