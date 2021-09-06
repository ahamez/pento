defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    {
      :ok,
      assign(socket,
        score: 0,
        message: "Guess a number",
        time: time(),
        number: random_number(),
        user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @time %>
    </h2>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-foo={n}><%= n %></a>
      <% end %>
      <pre>
        <%= @user.email %>
        <%= @user.username %>
        <%= @session_id %>
      </pre>
    </h2>
    """
  end

  @impl true
  def handle_event("guess", %{"foo" => guess} = data, socket)
      when guess == socket.assigns.number do
    IO.inspect(data)

    message = "Your guess: #{guess}. Correct."
    score = socket.assigns.score + 1

    {
      :noreply,
      assign(socket, message: message, score: score, time: time(), number: random_number())
    }
  end

  @impl true
  def handle_event("guess", %{"foo" => guess} = data, socket) do
    IO.inspect(data)
    IO.inspect(socket)

    message = "Your guess: #{guess}. Wrong. Guess again."
    score = socket.assigns.score - 1

    {
      :noreply,
      assign(socket, message: message, score: score, time: time(), number: socket.assigns.number)
    }
  end

  defp time() do
    DateTime.utc_now() |> to_string()
  end

  defp random_number() do
    to_string(Enum.random(1..10))
  end
end
