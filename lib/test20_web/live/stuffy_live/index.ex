defmodule Test20Web.StuffyLive.Index do
  use Test20Web, :live_view

  alias Test20.Stuffies
  alias Test20.Stuffies.Stuffy

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :stuffies, Stuffies.list_stuffies())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Stuffy")
    |> assign(:stuffy, Stuffies.get_stuffy!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Stuffy")
    |> assign(:stuffy, %Stuffy{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stuffies")
    |> assign(:stuffy, nil)
  end

  @impl true
  def handle_info({Test20Web.StuffyLive.FormComponent, {:saved, stuffy}}, socket) do
    {:noreply, stream_insert(socket, :stuffies, stuffy)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    stuffy = Stuffies.get_stuffy!(id)
    {:ok, _} = Stuffies.delete_stuffy(stuffy)

    {:noreply, stream_delete(socket, :stuffies, stuffy)}
  end
end
