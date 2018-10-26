defmodule TaskTracker.Repo.Migrations.AddManagerToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :manager_id, references(:users, on_delete: :nilify_all), null: True
    end
  end
end
