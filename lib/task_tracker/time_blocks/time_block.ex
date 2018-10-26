defmodule TaskTracker.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias TaskTracker.Tasks.Task

  schema "timeblocks" do
    field :end, :utc_datetime
    field :start, :utc_datetime

    belongs_to :task, Task

    timestamps()
  end

  @doc false
  def changeset(time_block, attrs) do
    time_block
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:start, :end, :task_id])
  end
end
