defmodule BasketTest do
  use ExUnit.Case
  doctest Kago

  test "worker can hold a basket" do
    {:ok, basket} = Kago.new_basket

    Kago.add_item(basket, %Kago.Item{price: 500})

    assert Kago.total_price(basket) == {:ok, 500}

    Kago.add_item(basket, %Kago.Item{price: 300})

    assert Kago.total_price(basket) == {:ok, 800}
  end
end
