defmodule PentoWeb.WrongLive do
  require Logger
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    rando = Enum.random(1..10)

    {:ok,
     assign(socket,
       score: 0,
       message: "Make a guess:",
       time: time(),
       to_guess: rando,
       game_won: false
     )}
  end

  def handle_event("guess", %{"number" => number}, socket) do
    to_guess = socket.assigns.to_guess

    Logger.info("to_guess: #{inspect(to_guess)}, number: #{inspect(number)}")

    score = socket.assigns.score
    make_message(to_guess, number |> String.to_integer(), score, socket)
  end

  def handle_params(_unsigned_params, _uri, socket) do
    rando = Enum.random(1..10)

    # reset the params to the default set, same as what's in mount/3
    # TODO obviously need to reduce the duplication
    {:noreply,
     assign(socket,
       score: 0,
       message: "Make a guess:",
       time: time(),
       to_guess: rando,
       game_won: false
     )}
  end

  def make_message(to_guess, number, current_score, socket) when to_guess == number do
    message = "You guessed #{number}. Correct!"

    {:noreply,
     assign(socket, message: message, score: current_score + 10, time: time(), game_won: true)}
  end

  def make_message(_, number, current_score, socket) do
    # what's the difference between :reply and :noreply?
    message = "You guessed #{number}. It is wrong. Guess again."

    {:noreply,
     assign(socket, message: message, score: current_score - 1, time: time(), game_won: false)}
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
      <%= if(not @game_won) do %>
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
      <% else %>
        <.link
          class="bg-blue-500 hover:bg-blue-700
          text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
          patch={~p"/guess"}
        >
          Restart
        </.link>
      <% end %>
    </h2>
    """
  end
end
