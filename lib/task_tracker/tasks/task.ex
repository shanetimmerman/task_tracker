defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias TaskTracker.TimeBlocks.TimeBlock
  alias TaskTracker.Users.User

  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :title, :string
    field :start_time, :utc_datetime

    belongs_to :user, User
    has_many :time_blocks, TimeBlock, foreign_key: :task_id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :user_id, :start_time])
    |> validate_required([:title, :description, :completed, :user_id, :start_time])
  end
end
