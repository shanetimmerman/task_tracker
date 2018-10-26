# Design Choices

This application was build under the assumption that users would be working
in a team environment. This is built off the stipulation that one user can
assign tasks to another user.

Given that users can assign tasks to their underlings and edit those tasks.
It would also make sense for other users to be able to edit this task, assuming that 
these users were collaborating. If making the task was an error, it would
also make sense for a user to be able to delete a task, even if it is not
assigned to them.

So, users have the ability to create, modify, and delete tasks either assigned to them
or their underlings.

All users also have the ability to create, delete, and modify users.
From a system admistration perspective, it would make sense for one user
to be able to create another user, rather than having that user be 
responsible for creating themselves. This is also the justification for
allowing users to delete other users.

Viewing a user allows you are view all the tasks assigned for that user, as well ass all tasks for your the direct underlings of that user. You can only edit the tasks assigned to you or your direct undelings.

Users cannot navigate the site until the have logged in or registered. This prevents tampering form non-registered users.

Navigation throughout the site is done through the minimalistic navigation bar at the top of the screen. This draws give more graphical impact to the task list, which in theory would help increase user focus.

Users cannot delete themselves, or anyone they do not manage.

Users are able to view total ellapsed time for a task on the tasks page. To see a more specific breakdown of timeblocks, they need to visit that specific task. Users can edit the time they worked on a task, create new timeblocks if they missed a period of work, and delete any incorrect timeblocks.

There is also a feature to clock in and clock out for a task. During this time clock in time is temporarily stored in a `start_time` field in the database. After the user clocked out, this temporary storage is erased and a time-block is created using that start time and whatevre time the user clocked out. 


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
