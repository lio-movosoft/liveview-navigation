defmodule Test20Web.StuffyLive.Show do
  use Test20Web, :live_view

  alias Test20.Stuffies

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:stuffy, Stuffies.get_stuffy!(id))}
  end

  defp page_title(:show), do: "Show Stuffy"
  defp page_title(:edit), do: "Edit Stuffy"
end
