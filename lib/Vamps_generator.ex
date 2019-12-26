defmodule VamGenserv do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(:perm, _from, state) do
      start = Enum.at(state,0)
      last = Enum.at(state,1)
      pid = Enum.at(state,2)

      seg = div(last - start, 8)
      a =  for i <- 0..div(last-start , seg)-1, do: (if start+(i+1)*seg >= last, do: [start + i * seg,last], else: [start + i * seg , start+ (i+1)*seg-1])
      b = for i <- a, do: i ++ [pid]

      ##stream = Task.async_stream(b, fn x -> VampireNumbers201909061710.generateVamps(x) end, timeout: 500000)
      stream = Task.async_stream(b, fn x -> VampireNumberscompresssed.generateVamps(x) end, timeout: 500000)
      Stream.run(stream)
      {:reply, pid, state}
  end
end
