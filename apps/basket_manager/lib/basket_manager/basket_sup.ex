defmodule BasketManager.BasketSup do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    children = [
      worker(BasketManager.Basket, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end

  def new_child(basket_id) do
    Supervisor.start_child(__MODULE__, [basket_id])
  end

  def terminate_child(pid) do
    Supervisor.terminate_child(__MODULE__, pid)
  end
end
