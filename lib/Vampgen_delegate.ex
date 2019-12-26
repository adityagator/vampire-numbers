defmodule Vamp_delegate do
   def delegate(start, last) do
      {:ok, pid} = VampStore.start_link(%{})
        for i <- 0..99 do
          {:ok, p1} = VamGenserv.start_link([start + i*1000, start + (i+1)*1000, pid])
           GenServer.call(p1, :perm, :infinity)
       end
       pid
   end
end
