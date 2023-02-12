defmodule LiveViewCounterWeb.Counter do
  use LiveViewCounterWeb, :live_view

  @topic "live"

  def mount(_params, _session, socket) do
    LiveViewCounterWeb.Endpoint.subscribe(@topic)
    {:ok, assign(socket, :count, 0)}
  end

  def handle_event("increment", _params, socket) do
    new_state = update(socket, :count, &(&1 + 1))
    LiveViewCounterWeb.Endpoint.broadcast_from(self(), @topic, "increment", new_state.assigns)
    {:noreply, new_state}
  end

  def handle_event("decrement", _params, socket) do
    new_state = update(socket, :count, &(&1 - 1))
    LiveViewCounterWeb.Endpoint.broadcast_from(self(), @topic, "decrement", new_state.assigns)
    {:noreply, new_state}
  end

  def handle_info(msg, socket) do
    {:noreply, assign(socket, count: msg.payload.count)}
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
