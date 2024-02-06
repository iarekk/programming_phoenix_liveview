defmodule Pento.Repo.Migrations.PopulateDefaultUsernames do
  use Ecto.Migration
  import Ecto.Query, only: [from: 2]

  def change do
    from(u in Pento.Accounts.User, update: [set: [username: u.email]])
    |> Pento.Repo.update_all([])

    alter(table(:users)) do
      modify :username, :citext, null: false
    end

    create(unique_index(:users, :username))
  end
end
