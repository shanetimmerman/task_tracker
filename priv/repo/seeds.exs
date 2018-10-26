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
alias TaskTracker.TimeBlocks.TimeBlock

require DateTime

Repo.insert!(%User{name: "bob", manager_id: nil})
Repo.insert!(%User{name: "janice", manager_id: nil})
Repo.insert!(%User{name: "howard", manager_id: 1})
Repo.insert!(%User{name: "carl", manager_id: 1})

Repo.insert!(%User{name: "alice", manager_id: 2})

Repo.insert!(%Task{
    title: "do your shit", 
    description: "seriously",
    completed: false,
    user_id: 1,
})

Repo.insert!(%Task{
    title: "task2", 
    description: "the second one",
    completed: false,
    user_id: 2,
})

Repo.insert!(%Task{
    title: "the third", 
    description: "the second one",
    completed: false,
    user_id: 3,
})

Repo.insert!(%Task{
    title: "for alice", 
    description: "dev",
    completed: false,
    user_id: 4,
})

Repo.insert!(%Task{
    title: "working on it", 
    description: "shows an in progress task",
    completed: false,
    user_id: 1,
    start_time: DateTime.utc_now(),
})

Repo.insert(%TimeBlock{
    start: DateTime.utc_now(),
    end: DateTime.utc_now(),
    task_id: 1,
})
