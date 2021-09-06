# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pento.Catalog

products = [
  %{
    name: "Chess",
    description: "A game.",
    sku: 123_456_789,
    unit_price: 10.00
  },
  %{
    name: "Tic-Tac-Toe",
    description: "A game.",
    sku: 234_567_890,
    unit_price: 11.00
  },
  %{
    name: "Table tennis",
    description: "A game.",
    sku: 345_678_901,
    unit_price: 12.00
  }
]

Enum.each(products, &Catalog.create_product(&1))
