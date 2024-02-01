defmodule PentoWeb.WrongLive do
  require Logger
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, initial_state(get_random_number()))}
  end

  def handle_event("guess", %{"number" => number}, socket) do
    to_guess = socket.assigns.to_guess
    score = socket.assigns.score
    guess = number |> String.to_integer()

    Logger.info("to_guess: #{inspect(to_guess)}, number: #{inspect(number)}")

    {:noreply, assign(socket, update_state(to_guess, guess, score))}
  end

  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, assign(socket, initial_state(get_random_number()))}
  end

  def initial_state(random_number) when random_number in 1..10 do
    # with_time is stateful, I wonder if there is a better way to add such aspects to models
    %{score: 0, message: "Make a guess:", to_guess: random_number, game_won: false} |> with_time()
  end

  def update_state(to_guess, guess, curent_score) when to_guess == guess do
    message = "You guessed #{guess}. Correct!"
    score = curent_score + 10

    %{message: message, score: score, game_won: true} |> with_time()
  end

  def update_state(to_guess, guess, current_score) do
    message = make_hint(to_guess, guess)
    score = current_score - 1

    %{message: message, score: score} |> with_time()
  end

  def make_hint(to_guess, guess) when to_guess > guess do
    "You guessed #{guess}. Too low! Try again."
  end

  def make_hint(to_guess, guess) when to_guess < guess do
    "You guessed #{guess}. Too high! Try again."
  end

  def with_time(state), do: state |> Map.put(:time, time())

  def time(), do: DateTime.utc_now() |> to_string()
  def get_random_number(), do: Enum.random(1..10)

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
