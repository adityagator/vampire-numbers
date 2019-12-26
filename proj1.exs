a = System.argv()
#IO.inspect a
start = String.to_integer(Enum.at(a,0))
last = String.to_integer(Enum.at(a,1))
{:ok, pid} = VampStore.start_link(%{})

seg = div(last - start, 4)
a =  for i <- 0..div(last-start , seg)-1, do: (if start+(i+1)*seg >= last, do: [start + i * seg,last], else: [start + i * seg , start+ (i+1)*seg-1])
b = for i <- a, do: i ++ [pid]

##IO.inspect b

{:ok, sup} = Vamps.Supervisor.start_link(b)

a = for x <- Supervisor.which_children(sup) do
     {_,pid,_,_} = x
     pid
    end
Enum.map(a, fn x-> GenServer.call(x, :perm, :infinity) end)

a = VampStore.value(pid)
b = Map.to_list(a)
b = Enum.sort(b)
b = List.flatten(b)
#IO.inspect b
#IO.inspect length(b)

   a = for x <- b do
        vamp = [elem(x,0), elem(x,1)]
        vamp = List.flatten(vamp)
        vamp
       end
    ##IO.inspect a
   for x <- a do
      for y<-x do
        IO.write(y)
        IO.write(" ")
     end
      IO.write("\n")
   end

Agent.stop(pid, :normal)
