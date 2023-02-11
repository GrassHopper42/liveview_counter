defmodule LiveViewCounterWeb.Counter do
  use LiveViewCounterWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def handle_event("increment", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("decrement", _params, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-4xl font-bold text-center"> The count is: <%= @count %> </h1>

      <p class="text-center">
        <button phx-click="decrement">-</button>
        <button phx-click="increment">+</button>
      </p>
    </div>
    """
  end
end
