# Design Choices

This application was build under the assumption that users would be working
in a team environment. This is built off the stipulation that one user can
assign tasks to another user.

Given that users can assign other users tasks, it would make sense for them
to also be able to edit those tasks after assigning them. It would also 
make sense for other users to be able to edit this task, assuming that 
these users were collaborating. If making the task was an error, it would
also make sense for a user to be able to delete a task, even if it is not
assigned to them.

So, all users have the ability to create, modify, and delete tasks.

All users also have the ability to create, delete, and modify users.
From a system admistration perspective, it would make sense for one user
to be able to create another user, rather than having that user be 
responsible for creating themselves. This is also the justification for
allowing users to delete other users.

There are no passwords, so there are no 'administrator' type privileges.
Since all accounts are public, any user could just sign in with that name.

The time is calcualted from the moment the task is created. This way the life of the task can be viewed at any point in time.

Viewing a user allows you are view all the tasks assigned for that user. This seems like a useful feature.

Users cannot navigate the site until the have logged in or registered. This prevents tampering form non-registered users.

Navigation throughout the site is done through the minimalistic navigation bar at the top of the screen. This draws give more graphical impact to the task list, which in theory would help increase user focus.

Users cannot delete themselves.

# TaskTracker

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
