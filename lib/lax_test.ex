import LAXer

deflamodule LAXTester do
	def test do
		([{"hello", "world"}, {"goodbye", ListDict}])["goodbye"]
	end
	def testdeep do
		x = [{"hello", "world"}, {"goodbye", [{"hello", "world"}, {"goodbye", ListDict}]}]
		x["goodbye"]["hello"]
	end
end