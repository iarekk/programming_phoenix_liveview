defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:", time: time())}
  end

  def handle_event("guess", %{"number" => number}, socket) do
    score = socket.assigns.score - 1
    message = "You guessed #{number}. It is wrong. Guess again."

    # what's the difference between :reply and :noreply?
    {:noreply, assign(socket, message: message, score: score, time: time())}
  end

  def time(), do: DateTime.utc_now() |> to_string()

  def render(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: <%= @score %></h1>

    <h2>
      <%= @message %> It's <%= @time %>.
    </h2>
    <br />
    <h2>
      <%= for n <- 1..10 do %>
        <.link
          class="bg-blue-500 hover:bg-blue-700
          text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
          phx-click="guess"
          phx-value-number={n}
        >
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end
end
