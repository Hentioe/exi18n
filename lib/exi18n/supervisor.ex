defmodule ExI18n.Supervisor do
  @moduledoc false
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [
      worker(ExI18n.Cache, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
