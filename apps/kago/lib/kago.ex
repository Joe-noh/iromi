defmodule Kago do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Kago.BasketSup, []),
    ]

    opts = [strategy: :one_for_one, name: Kago.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def new_basket do
    basket_id = generate_id()
    Kago.BasketSup.new_child(basket_id)

    {:ok, basket_id}
  end

  def add_item(basket_id, item) do
    if Kago.Basket.exists?(basket_id) do
      {:ok, Kago.Basket.add_item(basket_id, item)}
    else
      :error
    end
  end

  def total_price(basket_id) do
    if Kago.Basket.exists?(basket_id) do
      {:ok, Kago.Basket.total_price(basket_id)}
    else
      :error
    end
  end

  def basket_content(basket_id) do
    if Kago.Basket.exists?(basket_id) do
      {:ok, Kago.Basket.content(basket_id)}
    else
      :error
    end
  end

  def terminate(basket_id) do
    if Kago.Basket.exists?(basket_id) do
      Kago.Basket.terminate(basket_id)
    else
      :error
    end
  end

  def exists?(basket_id) do
    Kago.Basket.exists?(basket_id)
  end

  defp generate_id do
    :crypto.strong_rand_bytes(16)
    |> :base64.encode_to_string
    |> to_string
    |> String.replace(~r/[\n\=]/, "")
    |> String.replace(~r/\+/, "-")
    |> String.replace(~r/\//, "_")
  end
end
