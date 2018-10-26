defmodule TaskTracker.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias TaskTracker.Repo
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Users.User
  alias TaskTracker.Users

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> display_list()
  end

  def display_list(tasks) do
    tasks
    |> Enum.map(&to_user_name/1)
  end

  # def to_15_min(task) do

  #   st = Map.get(task, :start_time)
  #   now = DateTime.utc_now()

  #   diff = DateTime.diff(now, st)
    
  #   min_taken = diff / 60

  #   in_15 = trunc(trunc(min_taken + 15/2) / 15) * 15;

  #   Map.put(task, :start_time, in_15)
  # end

  def to_user_name(task) do
    u = Map.get(task, :user)
    user_data = Repo.get(User, u)
    name = user_data.name
    Map.put(task, :user, name)
  end

  def get_tasks_for_user(id) do
    Repo.all(from t in TaskTracker.Tasks, where: t.id == ^id, select: t, preload: [:timeblocks, :user])
    # |> Repo.preload([:timeblocks, :user])
  end

  def match_id?(task, id) do
    {id_num, _} = Integer.parse(id)
    task.user == id_num
  end


  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  def get_task(id) do
    Repo.get(Task, id)
    |> Repo.preload([:user, :time_blocks])   
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    attrs = name_to_userid(attrs)
    
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def name_to_userid(task) do
    name = Map.get(task, "user_id")
    user = Users.get_user_by_name(name)
    Map.put(task, "user_id", user.id)
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    attrs = name_to_userid(attrs)
    
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end
end
