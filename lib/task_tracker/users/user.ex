defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias TaskTracker.Tasks.Task

  schema "users" do
    field :name, :string
    belongs_to :manager, TaskTracker.Users.User
    has_many :underlings, TaskTracker.Users.User, foreign_key: :manager_id

    has_many :tasks, Task, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :manager_id])
    |> validate_required([:name, :manager_id])
  end
end
