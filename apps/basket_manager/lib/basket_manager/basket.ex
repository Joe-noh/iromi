defmodule BasketManager.Basket do
  use GenServer

  defstruct items: []

  # callbacks

  def start_link(basket_id) do
    GenServer.start_link(__MODULE__, nil, name: via(basket_id))
  end

  def init(_), do: {:ok, %BasketManager.Basket{}}

  def handle_cast({:add_item, item}, basket = %{items: items}) do
    new_state = %BasketManager.Basket{basket | items: [item | items]}

    {:noreply, new_state}
  end

  def handle_call(:total_price, _from, basket) do
    {:reply, calc_total(basket), basket}
  end

  def handle_call(:content, _from, basket = %{items: items}) do
    content = %{items: items, total_price: calc_total(basket)}
    {:reply, content, basket}
  end

  # interfaces

  def add_item(id, item) do
    GenServer.cast(via(id), {:add_item, item})
  end

  def total_price(id) do
    GenServer.call(via(id), :total_price)
  end

  def content(id) do
    GenServer.call(via(id), :content)
  end

  def terminate(id) do
    reg_tuple(id)
    |> :gproc.whereis_name
    |> BasketManager.BasketSup.terminate_child()
  end

  def exists?(basket_id) do
    reg_tuple(basket_id) |> :gproc.whereis_name() != :undefined
  end

  # private functions

  def reg_tuple(basket_id) do
    {:n, :l, {:basket, basket_id}}
  end

  defp via(basket_id) do
    {:via, :gproc, reg_tuple(basket_id)}
  end

  defp calc_total(%{items: items}) do
    Enum.reduce(items, 0, &(&1.price + &2))
  end
end
