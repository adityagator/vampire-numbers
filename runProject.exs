defmodule StartApp do
  def start_supervisor(args_list) do
      {:ok, pid} = Vamps.Supervisor.start_link(args_list)
      ch = for p <- Supervisor.which_children(pid) do
              {_,pid_,_}= x
              pid
           end
      for pid <- ch, do, GenServer.call(pid, :perm, :infinity)
  end

  def initialize(a,b) do
      {:ok, pid} = VampStore.start_link(%{})


  end
end
