defmodule Pento.FrequentlyAskedQuestionsTest do
  use Pento.DataCase

  alias Pento.FrequentlyAskedQuestions

  describe "questions" do
    alias Pento.FrequentlyAskedQuestions.Question

    import Pento.FrequentlyAskedQuestionsFixtures

    @invalid_attrs %{question: nil, answer: nil, votes: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert FrequentlyAskedQuestions.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert FrequentlyAskedQuestions.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{question: "some question", answer: "some answer", votes: 42}

      assert {:ok, %Question{} = question} = FrequentlyAskedQuestions.create_question(valid_attrs)
      assert question.question == "some question"
      assert question.answer == "some answer"
      assert question.votes == 42
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FrequentlyAskedQuestions.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{question: "some updated question", answer: "some updated answer", votes: 43}

      assert {:ok, %Question{} = question} = FrequentlyAskedQuestions.update_question(question, update_attrs)
      assert question.question == "some updated question"
      assert question.answer == "some updated answer"
      assert question.votes == 43
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = FrequentlyAskedQuestions.update_question(question, @invalid_attrs)
      assert question == FrequentlyAskedQuestions.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = FrequentlyAskedQuestions.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> FrequentlyAskedQuestions.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = FrequentlyAskedQuestions.change_question(question)
    end
  end
end
