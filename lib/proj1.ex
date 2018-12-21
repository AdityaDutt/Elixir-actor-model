defmodule Proj1 do
  use Application
@moduledoc """
This is the main module which takes arguments n and k from user, parses it and then converts them
to integer. Then, it calls Parent Module and passes the arguments n and k in that module.
"""
  def start(_type,_args) do

    n=Enum.at(System.argv(),0)
    k=Enum.at(System.argv(),1)
    n1=String.to_integer(n,10)
    k1=String.to_integer(k,10)
    Parent.start_link(n1,k1)

  end
end
