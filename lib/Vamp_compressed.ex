defmodule VampireNumberscompresssed do

    def generateVamps(state) do
      a = Enum.at(state,0)
      b = Enum.at(state,1)
     pid = Enum.at(state,2)
      for x <- a..b do
         perm_check([],Integer.digits(x),x,pid)
      end
    end


   def generateVamps(a, b, pid) do
     IO.puts("Called vamp numbers")
     IO.inspect VampStore.value(pid)
     IO.inspect a
     IO.inspect b
     for x <- a..b do
        perm_check([],Integer.digits(x),x,pid)
     end

     p = VampStore.value(pid)
     q = Map.to_list(p)
     r = Enum.sort(q)
     r
   end
   def perm_check(did, need_do, num, pid) when need_do==[] do
      fang = isVamp(did, num)
      if fang != [], do: VampStore.addVamp(pid, num, fang)
   end

   def perm_check(did, need_do, num, pid) when did==[] do
       for x <- need_do, x != 0 do
         ##IO.inspect need_do
         perm_check(did++[x], need_do -- [x], num, pid)
       end
  end

  def perm_check(did, need_do, num, pid) when length(did) == length(need_do) do
      a = for y <- need_do, rem(Enum.at(did, length(did)-1)*y,10) == rem(num,10), do: y
        for x <- need_do, x !=0 , length(a)!=0 do
             perm_check(did++[x], need_do -- [x], num, pid)
        end
  end

   def perm_check(did, need_do, num, pid) do
       for x <- need_do do
         perm_check(did++[x], need_do -- [x], num, pid)
       end
  end

   def isVamp(l,num) do
     len = length(l)
     d1 =  Enum.chunk_every(l, div(len,2))
     num1 = Integer.undigits(Enum.at(d1,0))
     num2 = Integer.undigits(Enum.at(d1,1))
     fangs = if num1*num2==num, do: (if num1>num2, do: [num2,num1], else: [num1,num2]), else: []
     fangs
   end
end
