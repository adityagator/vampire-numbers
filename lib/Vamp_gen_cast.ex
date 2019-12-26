defmodule VamGenserv1 do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast(:perm, state) do
      start = Enum.at(state,0)
      last = Enum.at(state,1)
      pid = Enum.at(state,2)
      p = VampireNumbers201909061710.generateVamps(start, last, pid)
      {:noreply, state}
  end
end
