class UsersController < ApplicationController

    get '/signup' do 
        if logged_in?
            redirect '/discs'
        else 
            erb :'/users/create_user'
        end 
    end 

    post '/signup' do 
        if params["name"] != "" && params["password"] != ""
            @user = User.create(params)
            @user.save 
            session[:user_id] = @user.id 
            redirect '/discs'
        end 
        "Please fill required fields"
        redirect '/signup'
        
    end 

    get '/login' do 
        if logged_in?
            redirect '/discs'
        else 
            erb :'users/login'
        end 

    end 

    post '/login' do 
        @user = User.find_by(name: params[:name])
        if @user.authenticate(params[:password])
            session[:user_id] = @user.id 
            redirect '/discs'
        else
            
            redirect '/signup? error=Please enter correct password'
        end 
    end 

    get '/logout' do 
        session.clear 
        redirect '/login'
    end 
    

end 