defmodule Proj1  do
   use Application

  def start_supervisor(args_list) do
      {:ok, pid} = Vamps.Supervisor.start_link(args_list)
      ch = for p <- Supervisor.which_children(pid) do
              {_,pid_,_} = p
              pid
           end
      for pid <- ch, do: GenServer.call(pid, :perm, :infinity)
  end

  def start(start,last) do
      IO.inspect start
      IO.inspect last
  end

end
