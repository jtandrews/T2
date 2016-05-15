require 'rails_helper'

RSpec.describe InstagramController, type: :controller do
	# Test 1
	describe "Request OK" do
    	it '- Http status correcto cuando request es correcto' do
			params = {'tag' => 'Santiago', 'access_token' => '1442649438.1677ed0.da39352fcbe04712ba35f360d1a98762'}
			post :buscarTag, params.merge(format: :json)
			res = JSON.parse response.body
			expect(response).to have_http_status(200)
		end
	end

	# Test 2
	describe "Check no tag case" do
		it '- Http status 400 si no hay tag' do
			params = {'access_token' => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'}
			post :buscarTag, params.merge(format: :json)
			res = JSON.parse response.body
			expect(response).to have_http_status(400)
		end
	end

	# Test 3
	describe "Check bad tag case" do
		it '- Http status 400 si tag es vacío' do
			params = {'tag' => '','access_token' => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'}
			post :buscarTag, params.merge(format: :json)
			res = JSON.parse response.body
			expect(response).to have_http_status(400)
		end
	end

	# Test 4
	describe "Check bad token case" do 
		it '- Http status 400 cuando token es incorrecto' do
			params = {'tag' => 'santiago', 'access_token' => 'bad_token'}
			post :buscarTag, params.merge(format: :json)
			res = JSON.parse response.body
			expect(response).to have_http_status(400)
		end
	end

	# Test 5
	# describe "Check json response" do 
	# 	it '- Elementos no nulos si el request es correcto' do
	# 		params = {'tag' => 'santiago', 'access_token' => '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'}
	# 		post :buscarTag, params.merge(format: :json)
	# 		res = JSON.parse(response.body)
	# 		expect(res['posts']).should_not be_nil
	# 		if res != nil
	# 			if res['posts'][0] != nil
	# 				expect(res['posts'][0]['username']).should_not be_nil
	# 				expect(res['posts'][0]['tags']).should_not be_nil
	# 				expect(res['posts'][0]['likes']).should_not be_nil
	# 				expect(res['posts'][0]['url']).should_not be_nils
	# 				expect(res['posts'][0]['version']).should_not be_nil
	# 			end
	# 		end
	# 	end
	# end
end