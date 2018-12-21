defmodule Child do
  use GenServer
@moduledoc """
This module is a worker and is called by supervisor. Supervisor calls this module multiple times
to run multiple actors concurrently.It uses GenServer to find output in the given range.
After GenServer is initialised, Genserver.cast is used to find out output in k sized ranges asynchronously.
Then, output is printed on console.
"""

  def init(state), do: {:ok, state}

  def start_link(beg_p,end_p,ind,d,n,k) do
    {:ok,pid}=GenServer.start_link(__MODULE__,[beg_p,end_p,ind,d,n,k])
    if ind<d do
        GenServer.cast(pid,{:enqueue,beg_p,end_p,k})
    else
        GenServer.cast(pid,{:enqueue,beg_p,n,k})
    end
    {:ok,pid}
  end

  def calculate(b,e) when b<e do
    sum= e*(e + 1)*( (2*e) + 1) - (b-1) *b*((2*b) - 1)
    s=div(sum,6)
    z = round(:math.sqrt(s))
    z1=z*z
    if z1==s do
        IO.puts("#{b}")
     end
   end

  def handle_cast({:enqueue, v1,v2,v3}, state) do
    Enum.each(v1..v2,fn(x)->calculate(x,x+v3-1) end )
    {:noreply,state}
   end

end
