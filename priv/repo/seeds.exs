# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskTracker.Repo.insert!(%TaskTracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TaskTracker.Repo
alias TaskTracker.Users.User
alias TaskTracker.Tasks.Task

require DateTime

Repo.insert!(%User{name: "alice"})
Repo.insert!(%User{name: "bob"})

Repo.insert!(%Task{
    title: "do your shit", 
    description: "seriously",
    start_time: DateTime.utc_now(),
    completed: false,
    user: 1,
})
