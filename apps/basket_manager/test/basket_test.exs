defmodule BasketTest do
  use ExUnit.Case
  doctest BasketManager

  test "worker can hold a basket" do
    {:ok, basket} = BasketManager.new_basket

    BasketManager.add_item(basket, %BasketManager.Item{price: 500})

    assert BasketManager.total_price(basket) == 500

    BasketManager.add_item(basket, %BasketManager.Item{price: 300})

    assert BasketManager.total_price(basket) == 800
  end
end
