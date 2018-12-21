defmodule Parent do
  use Supervisor
@moduledoc """
This module is a supervisor which runs module child as it's workers.
This module takes argument (n,k) and then initializes supervisor. It divides the
work among 100 actors. So, by dividing n by 100 we can find the size of work unit that
each worker will handle. Then, function calc(arg1,arg2,arg3,arg4) is called.
arg1 is divisions, arg2 is n, arg3 is work unit size, arg4 is k. In our case divisions is 100.
Then Supervisor starts workers and they run concurrently.
"""
  def start_link(n,k) do
    Supervisor.start_link(__MODULE__,[n,k])
  end

  def init(args \\ [])  do
     n=Enum.at(args,0)
     k=Enum.at(args,1)
     divisions=  100  # divisions is number of actors which is 100 in our case
     parts = div(n,divisions)  #parts denotes work unit size
     calc(divisions,n,parts,k)
  end

  def calc(d,n,p,k) when n>d do
    children =
     Enum.map(1..d, fn(x)->
     worker(Child,[(x-1)*p + 1,(p)*x  ,x,d,n,k], [id: x,restart: :transient])
     end)
     supervise(children, strategy: :one_for_one)
  end

  def calc(d,n,p,k) when n<=d do
   children =
      Enum.map(1..1, fn(x)->
      worker(Child, [ (x-1)*p + 1,n ,x,d,n,k], [id: x, restart: :transient])
      end)
   supervise(children, strategy: :one_for_one)
  end

end
