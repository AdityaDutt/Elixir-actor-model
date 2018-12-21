defmodule Proj1.Main do
  use Application
  def start(_type,_args) do

    n=Enum.at(System.argv(),0)
    k=Enum.at(System.argv(),1)
    n1=String.to_integer(n,10)
    k1=String.to_integer(k,10)
    Parent.start_link(n1,k1)

  end
end
