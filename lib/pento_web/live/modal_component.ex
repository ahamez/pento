defmodule PentoWeb.ModalComponent do
  use PentoWeb, :live_component

  @impl true
  def mount(socket) do
    IO.puts("Custom mount for #{__MODULE__}")
    {:ok, socket |> assign(:custom_assign, "CUSTOM ASSIGN")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div
      id={@id}
      class="phx-modal"
      phx-capture-click="click_close_event"
      phx-window-keydown="key_close_event"
      phx-key= "escape"
      phx-target={@myself}
      phx-page-loading>

      <div class="phx-modal-content">
        Inside module <%= inspect(__MODULE__) %>
        <br/>
        Custom assign <%= inspect(@custom_assign) %>
        <%= live_patch raw("❌"), to: @return_to, class: "phx-modal-close" %>
        <%= live_component @component, @opts %>
      </div>
    </div>
    """
  end

  # Click outside the modal window
  @impl true
  def handle_event("click_close_event", metadata, socket) do
    IO.inspect(metadata, label: "#{__MODULE__} click close event metadata")
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end

  @impl true
  def handle_event("key_close_event", metadata, socket) do
    IO.inspect(metadata, label: "#{__MODULE__} key close event metadata")
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
