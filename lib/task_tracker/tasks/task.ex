defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :start_time, :utc_datetime
    field :title, :string
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :start_time, :completed, :user])
    |> validate_required([:title, :description, :start_time, :completed, :user])
  end
end
