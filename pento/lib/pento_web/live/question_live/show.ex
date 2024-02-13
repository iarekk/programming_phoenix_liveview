defmodule PentoWeb.QuestionLive.Show do
  use PentoWeb, :live_view

  alias Pento.FrequentlyAskedQuestions
  alias Pento.FrequentlyAskedQuestions.Question

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:question, FrequentlyAskedQuestions.get_question!(id))}
  end

  defp page_title(:show), do: "Show Question"
  defp page_title(:edit), do: "Edit Question"

  @impl true
  def handle_event("upvote", %{"id" => id}, socket) do
    question = FrequentlyAskedQuestions.get_question!(id)
    {:ok, _} = FrequentlyAskedQuestions.upvote(question)

    {:noreply,
     socket
     |> assign(:question, %Question{
       question
       | votes: question.votes + 1
     })}
  end
end
