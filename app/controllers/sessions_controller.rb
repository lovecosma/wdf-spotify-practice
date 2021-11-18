class SessionsController < ApplicationController


def login_with_spotify

    url = "https://accounts.spotify.com/authorize"
        query_params = {
            client_id: Rails.application.credentials.spotify[:client_id],
            response_type: "code",
            redirect_uri: "http://localhost:3000/auth/spotify/callback",
            scope: "playlist-modify-public playlist-read-collaborative user-library-read"
        }
        redirect_to url + "?" +  query_params.to_query
end 



end
