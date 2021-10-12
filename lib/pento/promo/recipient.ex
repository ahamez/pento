defmodule Pento.Promo.Recipient do
  @types %{
    first_name: :string,
    email: :string
  }
  @keys Map.keys(@types)
  defstruct @keys

  alias __MODULE__

  import Ecto.Changeset

  def changeset(%Recipient{} = user, attrs) do
    {user, @types}
    |> cast(attrs, @keys)
    |> validate_required([:first_name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
