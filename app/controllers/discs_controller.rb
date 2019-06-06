class DiscsController < ApplicationController

    get '/discs' do 
        if logged_in?
            @user = User.find_by_id(session[:user_id])
            @discs = Disc.all 
            erb :'discs/discs'
        else 
            redirect '/login'
        end 
    end 

    get '/discs/new' do 
        if logged_in?
            erb :'/discs/create_disc'
        else 
            redirect 'login'
        end 
    end 

    post '/discs/new' do 
        if logged_in?
            if params[:name] !=""
                @disc = Disc.create(params)
                @disc.user_id = session[:user_id]
                @disc.save
            end 
            redirect "/discs/#{@disc.id}"
        else 
            redirect '/login'
        end 
    end 

    get "/users/:slug" do 
        erb :'users/show'
    end 
    
    get "discs/:id" do 
        if logged_in?
            @disc = Disc.find_by(params[:id])
            erb :'/discs/show'
        else 
            redirect '/login'
        end 
    end 

    get "/discs/:id/edit" do 
        if logged_in?
            @disc = Disc.find_by(params[:id])
            if @disc.user_id == session[:user_id]
                erb :'discs/edit'
            else
                "You are not authorized to edit this disc"
            end 
        else 
            redirect '/login'
        end 
    end 

    post "/discs/:id/edit" do 
        if logged_in?
            if params[:name] != "" && params[:color] != "" && params[:weight] != ""
                @disc = Disc.find_by(params[:id])
                @disc.name = params[:name]
                @disc.color = params[:color]
                @disc.weight = params[:weight]
                @disc.save
                redirect "/discs/#{@disc.id}"
            else 
                "Please complete all fields"
            end 
        else 
            redirect '/login'
        end 
    end 

    get "/discs/:id/delete" do 
        if logged_in?
            @disc = Disc.find_by(params[:id])
            if @disc.user_id == session[:user_id]
                @disc.delete 
            end 
            redirect '/discs'
        else 
            redirect '/login'
        end 
    end 
end 