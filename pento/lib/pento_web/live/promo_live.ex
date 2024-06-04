defmodule PentoWeb.PromoLive do
  require Logger
  use PentoWeb, :live_view
  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_recipient()
     |> clear_form()}
  end

  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      recipient |> Promo.change_recipient(recipient_params) |> Map.put(:action, :validate)

    Logger.info("handle event recipient params: #{inspect(recipient_params)}")

    {:noreply, assign_form(socket, changeset)}
  end

  def assign_recipient(socket) do
    socket |> assign(:recipient, %Recipient{})
  end

  def clear_form(socket) do
    socket
    |> assign_form(
      socket.assigns.recipient
      |> Promo.change_recipient()
    )
  end

  def assign_form(socket, changeset) do
    socket |> assign(:form, to_form(changeset))
  end
end
