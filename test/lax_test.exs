defmodule LaxTest do
  use ExUnit.Case

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "deflamodule works" do
  	result = LAXTester.test
  	IO.puts inspect(result)
  end
  test "deflamodule works in depth" do
  	result = LAXTester.testdeep
  	IO.puts inspect(result)
  end
end
