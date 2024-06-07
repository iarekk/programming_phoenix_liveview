defmodule Pento.Promo do
  require Logger
  alias Pento.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(%Recipient{} = recipient, attrs) do
    changeset = change_recipient(recipient, attrs)

    not_fail_on_purpose =
      attrs["first_name"] != "Failname"

    case changeset.valid? and not_fail_on_purpose do
      true ->
        {:ok, %Recipient{}}

      false ->
        {:error, changeset}
    end

    # Logger.info("Sent a promo to #{changeset.email}")
  end
end
