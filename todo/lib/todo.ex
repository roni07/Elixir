defmodule Todo do
  # todo - complete later
  def create_todo do
    # without pipe
    # number_of_todo = IO.gets("Enter your todo: ")
    # {task_number, _q} = Integer.parse(number_of_todo)
    # task_number

    # with pipe operator
    {task_number, _} =
      IO.gets("Enter your number of todo: ")
      |> Integer.parse()

    for _ <- 1..task_number,
        do:
          IO.gets("Enter your task: ")
          |> String.trim()
  end

  def temp_todo, do: ["eat apple", "learn elixir", "workout", "read book"]

  def complete_todo(tasks, task) do
    if contains?(tasks, task) do
      List.delete(tasks, task)
    else
      :not_found_error
    end
  end

  def add_new_todo(tasks, task), do: List.insert_at(tasks, -1, task)

  def contains?(tasks, task), do: Enum.member?(tasks, task)

  def search_todo(tasks, word), do: for(task <- tasks, String.contains?(task, word), do: task)

  def random_task(tasks) do
    [task] = Enum.take_random(tasks, 1)
    task
  end

  def save(tasks, filename) do
    # invoking erlang code
    # converting our list so that it can be written to our file system
    binary = :erlang.term_to_binary(tasks)
    File.write(filename, binary)
  end

  def read(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "File does not found"
    end
  end
end
