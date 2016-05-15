require 'rest_client'
require 'json'
require 'rubygems'

class InstagramController < ApplicationController

	skip_before_filter  :verify_authenticity_token
	def buscarTag
		url = 'https://api.instagram.com/v1/tags/'
		version = '1.0.3'
		# token = '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'
		tag = params[:tag].to_s
		access_token = params[:access_token].to_s
		responseCount = JSON.parse RestClient.get url + tag + '?access_token=' + access_token
		puts '___RESPONSECOUNT: ' + responseCount.to_s
		total = responseCount['data']['media_count']

		response = JSON.parse RestClient.get url + tag + '/media/recent?access_token=' + access_token + '&count=3&min_tag_id=0&max_tag_id=0'
		puts '___RESPONSE: ' + response.to_s
				
		# Formamos el JSON que retornará de acuerdo a cantidad de posts (máximo retorna 3)
		final_string = '{"metadata":{"total":"'+total.to_s+'"},"posts":[{'
		if total == 0
			final_string += '}]'
		else
			if total > 0
				puts '___POST #1___'
				type1 = response['data'][0]['type'].to_s
				tags1 = response['data'][0]['tags'].to_s
				username1 = response['data'][0]['user']['username'].to_s
				likes1 = response['data'][0]['likes']['count'].to_s
				final_string += '"tags":'+tags1+',"username":"'+username1+'","likes":'+likes1

				url1 = ''
				if type1 == 'image'
					url1 = response['data'][0]['images']['standard_resolution']['url'].to_s
					if url1 == ''
						url1 = response['data'][0]['images']['low_resolution']['url'].to_s
						if url1 == ''
							url1 = response['data'][0]['images']['thumbnail']['url'].to_s
						end
					end
				elsif type1 == 'video'
					url1 = response['data'][0]['videos']['standard_resolution']['url'].to_s
					if url1 == ''
						url1 = response['data'][0]['videos']['low_resolution']['url'].to_s
						if url1 == ''
							url1 = response['data'][0]['videos']['thumbnail']['url'].to_s
						end
					end
				end
				text1 = response['data'][0]['caption']['text'].to_s
				final_string += ',"url":"'+url1+'","caption":"'+text1+'"}'	
				puts '___final_string:'+final_string

				if total > 1
					puts '___POST #2___'
					type2 = response['data'][1]['type'].to_s
					tags2 = response['data'][1]['tags'].to_s
					username2 = response['data'][1]['user']['username'].to_s
					likes2 = response['data'][1]['likes']['count'].to_s
					final_string += ',{"tags":'+tags2+',"username":"'+username2+'","likes":'+likes2

					url2 = ''
					if type2 == 'image'
						url2 = response['data'][1]['images']['standard_resolution']['url'].to_s
						if url2 == ''
							url2 = response['data'][1]['images']['low_resolution']['url'].to_s
							if url2 == ''
								url2 = response['data'][1]['images']['thumbnail']['url'].to_s
							end
						end
					elsif type2 == 'video'
						url2 = response['data'][1]['videos']['standard_resolution']['url'].to_s
						if url2 == ''
							url2 = response['data'][1]['videos']['low_resolution']['url'].to_s
							if url2 == ''
								url2 = response['data'][1]['videos']['thumbnail']['url'].to_s
							end
						end
					end
					text2 = response['data'][1]['caption']['text'].to_s
					final_string += ',"url":"'+url2+'","caption":"'+text2+'"}'	
					puts '___final_string:'+final_string

					if total > 2
						puts '___POST #3___'
						type3 = response['data'][2]['type'].to_s
						tags3 = response['data'][2]['tags'].to_s
						username3 = response['data'][2]['user']['username'].to_s
						likes3 = response['data'][2]['likes']['count'].to_s
						final_string += ',{"tags":'+tags3+',"username":"'+username3+'","likes":'+likes3

						url3 = ''
						if type3 == 'image'
							url3 = response['data'][2]['images']['standard_resolution']['url'].to_s
							if url3 == ''
								url3 = response['data'][2]['images']['low_resolution']['url'].to_s
								if url3 == ''
									url3 = response['data'][2]['images']['thumbnail']['url'].to_s
								end
							end
						elsif type3 == 'video'
							url3 = response['data'][2]['videos']['standard_resolution']['url'].to_s
							if url3 == ''
								url3 = response['data'][2]['videos']['low_resolution']['url'].to_s
								if url3 == ''
									url3 = response['data'][2]['videos']['thumbnail']['url'].to_s
								end
							end
						end
						text3 = response['data'][2]['caption']['text'].to_s
						final_string += ',"url":"'+url3+'","caption":"'+text3+'"}'
						puts '___final_string:'+final_string	
					end
				end
			end
			final_string += ']'
		end
		final_string += ',"version":"'+version+'"}'
		puts '___CONVERSION___'						
		final = JSON.parse(final_string)
		puts '___CONVERTIDO!!!___'
		puts final.to_s
		render json: final, status: 200

		rescue Exception => e
			puts '_______ERROR : ' + e.to_s
	    	render json: {:error => e.to_s}.to_json, status: 400
	end
	# def prueba
	# 	puts '_________PROBAAANDOOO!_________'
	# 	render json: {}.to_json, status: 200
	# end
end
