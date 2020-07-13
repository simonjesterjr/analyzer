

context "basic structure" do
		before :example do
			response = JSON.parse( File.read( 'spec/support/sample.json' ) )
			allow( HTTParty ).to receive( :get ).and_return( response )



		end

end
