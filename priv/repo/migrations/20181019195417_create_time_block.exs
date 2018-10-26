defmodule TaskTracker.Repo.Migrations.CreateTimeBlocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start, :utc_datetime
      add :end, :utc_datetime
      add :task_id, references(:tasks, on_delete: :delete_all)
      
      timestamps()
    end

  end
end
