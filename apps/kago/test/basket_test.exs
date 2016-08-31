defmodule BasketTest do
  use ExUnit.Case
  doctest Kago

  test "basket can hold items and calculate total price" do
    {:ok, basket} = Kago.new_basket

    Kago.add_item(basket, %Kago.Item{price: 500})

    assert Kago.total_price(basket) == {:ok, 500}

    Kago.add_item(basket, %Kago.Item{price: 300})

    assert Kago.total_price(basket) == {:ok, 800}
  end

  test "basket can hold items and show its content" do
    {:ok, basket} = Kago.new_basket

    Kago.add_item(basket, plate = %Kago.Item{name: "plate", price: 300})
    Kago.add_item(basket, spoon = %Kago.Item{name: "spoon", price: 100})

    {:ok, content} = Kago.basket_content(basket)

    assert plate in content.items
    assert spoon in content.items
  end
end
