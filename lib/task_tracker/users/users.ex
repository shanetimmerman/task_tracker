defmodule TaskTracker.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker.Repo

  alias TaskTracker.Users.User
  alias TaskTracker.Tasks

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def list_users_preload_manager do
    Repo.all(User)
    |> Repo.preload(:manager)
  end

  def get_names do
    users = list_users()
    users
    |> Enum.map(fn (user) -> user.name end)
  end

  def get_managed_names(id) do
    IO.puts(id)
    users = list_users()
    users
    |> Enum.filter(&(&1.id == id or &1.manager_id == id))
    |> Enum.map(&(&1.name))
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user(id) do
    Repo.get(User, id)
    |> Repo.preload(:manager)
    |> Repo.preload(:underlings)
  end

  def get_names_not_id(id) do
    Repo.all from u in User, select: u.name, where: u.id != ^id
  end


  def manager_name_to_id(user_params) do
    case Map.get(user_params, "manager_id") do
      "None" -> Map.delete(user_params, "manager_id")
      name -> Map.put(user_params, "manager_id", get_user_by_name(name).id)
    end
  end

  def get_user_preload_all(id) do
    Repo.get(User, id)
    |> Repo.preload([:underlings, :manager, :tasks])
  end
  
  def get_user_by_name(name) do
    Repo.get_by(User, name: name)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def get_tasks_for_user(id) do
    Tasks.get_tasks_for_user(id)
  end

  def get_underling_tasks(id) do
    user = get_user_preload_all(id)
    Map.put(user, :underlings, Enum.map(user.underlings, &query_user_tasks/1))
  end

  def query_user_tasks(user) do
    user = user
    |> Repo.preload(:tasks)
    user = Map.put(user, :tasks, Enum.map(user.tasks, &(&1 |> Repo.preload(:time_blocks))))
    IO.inspect user
    user
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
