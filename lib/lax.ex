defmodule Lax do
  use Application

  def start(_type, _args) do
    Lax.Supervisor.start_link
  end
end

defmodule LAXer do
	defmodule Transformer do
		def exec({ {:., _, [Access, :get]}, _, [subj, key]}) do
			quote do
				LAXer.getter(unquote(exec(subj)), unquote(exec(key)))
			end
		end
		def exec({ op, misc, args }) when is_list(args) do
			{op, misc, (for arg <- args, do: exec(arg))}
		end	
		def exec(code) when is_list(code) do
			for subcode <- code, do: exec(subcode)
		end
		def exec({:do, code}) do
			{:do, exec(code)}
		end
		def exec(code), do: code
	end

	defp scan_proplist([], _), do: nil
	defp scan_proplist([{key, value}|_rest], key), do: value
	defp scan_proplist([_|rest], key), do: scan_proplist(rest, key)

	def getter(subject, key) when not(is_atom(key)) and is_list(subject) do
		scan_proplist(subject, key)
	end
	def getter(subject, key) do
		Dict.get(subject, key)
	end
	defmacro la(code) do
		Transformer.exec(code)
	end
	defmacro deflamodule(name, code) do
		quote do
			defmodule unquote(name), unquote(Transformer.exec(code))
		end
	end
end

