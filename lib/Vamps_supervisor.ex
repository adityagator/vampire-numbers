defmodule Vamps.Supervisor do
  use Supervisor

  def start_link(state) do
    Supervisor.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    children =  for x<-state, do: worker(VamGenserv, [x], [id: Enum.at(x,0)*1000+3])
    Supervisor.init(children, strategy: :one_for_one)
  end
end
