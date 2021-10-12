defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view

  alias Pento.Promo
  alias Pento.Promo.Recipient

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect(socket.assigns, label: "👉 #{__MODULE__} socket.assigns")

    {
      :ok,
      socket
      |> assign_recipient()
      |> assign_changeset()
    }
  end

  @impl true
  def handle_event("validate", %{"recipient" => recipient_params}, socket) do
    Logger.debug("Validation")

    changeset =
      socket.assigns.recipient
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"recipient" => _recipient_params}, socket) do
    Logger.debug("HERE")
    # changeset =
    #   socket.assigns.recipient
    #   |> Promo.change_recipient(recipient_params)
    #   |> Map.put(:action, :validate)

    # {:noreply, assign(socket, :changeset, changeset)}
    {:noreply, socket}
  end

  # -- Private

  defp assign_recipient(socket) do
    assign(socket, :recipient, %Recipient{})
  end

  defp assign_changeset(socket) do
    recipient = socket.assigns.recipient

    assign(socket, :changeset, Promo.change_recipient(recipient))
  end
end
