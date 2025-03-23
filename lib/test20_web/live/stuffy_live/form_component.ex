defmodule Test20Web.StuffyLive.FormComponent do
  use Test20Web, :live_component

  alias Test20.Stuffies

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage stuffy records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="stuffy-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Stuffy</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{stuffy: stuffy} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Stuffies.change_stuffy(stuffy))
     end)}
  end

  @impl true
  def handle_event("validate", %{"stuffy" => stuffy_params}, socket) do
    changeset = Stuffies.change_stuffy(socket.assigns.stuffy, stuffy_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"stuffy" => stuffy_params}, socket) do
    save_stuffy(socket, socket.assigns.action, stuffy_params)
  end

  defp save_stuffy(socket, :edit, stuffy_params) do
    case Stuffies.update_stuffy(socket.assigns.stuffy, stuffy_params) do
      {:ok, stuffy} ->
        notify_parent({:saved, stuffy})

        {:noreply,
         socket
         |> put_flash(:info, "Stuffy updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_stuffy(socket, :new, stuffy_params) do
    case Stuffies.create_stuffy(stuffy_params) do
      {:ok, stuffy} ->
        notify_parent({:saved, stuffy})

        {:noreply,
         socket
         |> put_flash(:info, "Stuffy created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
