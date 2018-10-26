defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Users
  
  require DateTime

  def index(conn, _params) do
    if (!get_session(conn, :user_id)) do
      conn
      |> put_flash(:error, "You must log in first")
      |> redirect(to: Routes.page_path(conn, :index))
    else 
      redirect(conn, to: Routes.user_path(conn, :show, get_session(conn, :user_id)))
    end
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    users = Users.get_managed_names(get_session(conn, :user_id))
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
    IO.puts(task)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task(id)
    changeset = Tasks.change_task(task)
    users = Users.get_names()
    render(conn, "edit.html", task: task, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    IO.inspect task_params
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "task" => "start"}) do
    task = Tasks.get_task!(id)
    IO.puts "you did it"
    Tasks.update_task(id, %{"start_time" => DateTime.utc_now()})
    put_flash(conn, :info, "Task #{task.title} has started.")
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
