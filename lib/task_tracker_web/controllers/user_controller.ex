defmodule TaskTrackerWeb.UserController do
  use TaskTrackerWeb, :controller

  alias TaskTracker.Users
  alias TaskTracker.Users.User

  def index(conn, _params) do
    if (!get_session(conn, :user_id)) do
      conn
      |> put_flash(:error, "You must log in first")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      users = Users.list_users_preload_manager()
      render(conn, "index.html", users: users)
    end
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    users = Users.get_names()
    users = List.insert_at(users, 0, "None")
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    user_params = Users.manager_name_to_id(user_params)
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.user_path(conn, :index))
        
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_underling_tasks(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user(id)
    users = Users.get_names_not_id(id)
    users = List.insert_at(users, 0, "None")
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, users: users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    user_params = Users.manager_name_to_id(user)
    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    {id_num, _} = Integer.parse(id)
    if (get_session(conn, :user_id) == id_num) do
      conn
      |> put_flash(:error, "You cannot delete yourself")
      |> redirect(to: Routes.user_path(conn, :index))
    else
      user = Users.get_user!(id)
      {:ok, _user} = Users.delete_user(user)

      conn
      |> put_flash(:info, "User deleted successfully.")
      |> redirect(to: Routes.user_path(conn, :index))
    end
  end
end
