class UsersController < ApplicationController

    def find_or_create_spotify_user
        url = "https://accounts.spotify.com/api/token"
        body = {
            grant_type: "authorization_code",
            code: params[:code],
            redirect_uri: "http://localhost:3000/auth/spotify/callback",
            client_id: Rails.application.credentials.spotify[:client_id],
            client_secret: Rails.application.credentials.spotify[:client_secret]
        }
        resp = RestClient.post(url, body)
        auth_params = JSON.parse(resp.body)
        session[:access_token] = auth_params["access_token"]
        session[:refresh_token] = auth_params["refresh_token"]
        headers = {
            "Authorization": "Bearer #{auth_params["access_token"]}",
            "Content-Type": "application/json"
        }
        resp = RestClient.get("https://api.spotify.com/v1/me", headers)
        user_params = JSON.parse(resp)
        @user = User.find_or_create_by(spotify_id: user_params["id"]) do |u| 
            u.display_name = user_params["display_name"]
        end 

        session[:user_id] = @user.id

        render :profile_page
    end 



end
