defmodule Pento.Repo.Migrations.AddUsernameField do
  use Ecto.Migration

  # following advice in this thread, dropping the data migration from the migration list
  # https://elixirforum.com/t/why-does-this-code-work-as-2-separate-migrations-but-not-as-a-single-one/61506/3

  def change do
    alter(table(:users)) do
      add :username, :citext, null: false
    end

    create(unique_index(:users, :username))
  end
end
