defmodule Pento.Promo do
  alias Pento.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(%Recipient{email: email} = _recipient, _attrs) do
    IO.puts("Sent a promo to #{email}")
    # don't know why we aren't using the recipient param that's passed in...
    {:ok, %Recipient{}}
  end
end
