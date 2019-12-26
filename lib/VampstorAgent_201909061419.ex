defmodule VampStore do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def value(pid) do
    Agent.get(pid, fn state -> state end)
  end

  def addVamp(pid,n,x) do
     Agent.update(pid, fn state -> if state[n] == nil, do: state = Map.put(state,n,[x]), else: (if x not in state[n],do: state = Map.put(state,n, state[n]++[x]), else: state) end,5000)
  end
end
