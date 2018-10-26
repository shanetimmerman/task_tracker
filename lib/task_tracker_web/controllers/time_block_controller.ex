defmodule TaskTrackerWeb.TimeBlockController do
  use TaskTrackerWeb, :controller
  
  alias TaskTracker.TimeBlocks
  alias TaskTracker.TimeBlocks.TimeBlock
  
  require DateTime

  def index(conn, _params) do
    time_block = TimeBlocks.list_time_block()
    render(conn, "index.html", time_block: time_block)
  end

  def new(conn, _params) do
    changeset = TimeBlocks.change_time_block(%TimeBlock{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"time_block" => time_block_params}) do
    case TimeBlocks.create_time_block(time_block_params) do
      {:ok, time_block} ->
        conn
        |> put_flash(:info, "Time block created successfully.")
        |> redirect(to: Routes.time_block_path(conn, :show, time_block))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    time_block = TimeBlocks.get_time_block!(id)
    render(conn, "show.html", time_block: time_block)
  end

  def edit(conn, %{"id" => id}) do
    time_block = TimeBlocks.get_time_block(id)
    changeset = TimeBlocks.change_time_block(time_block)
    render(conn, "edit.html", time_block: time_block, changeset: changeset)
  end

  def update(conn, %{"id" => id, "time_block" => time_block_params}) do
    time_block = TimeBlocks.get_time_block!(id)

    case TimeBlocks.update_time_block(time_block, time_block_params) do
      {:ok, time_block} ->
        conn
        |> put_flash(:info, "Time block updated successfully.")
        |> redirect(to: Routes.time_block_path(conn, :show, time_block))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", time_block: time_block, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_block = TimeBlocks.get_time_block!(id)
    {:ok, _time_block} = TimeBlocks.delete_time_block(time_block)

    conn
    |> put_flash(:info, "Time block deleted successfully.")
    |> redirect(to: Routes.time_block_path(conn, :index))
  end
end
