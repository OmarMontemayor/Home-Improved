class ProjectsController < ApplicationController
    #index action
    get '/projects' do
        redirect_if_not_logged_in
        @projects = current_user.projects
        erb :'projects/index'
    end

    #new action(view for form that will create)
    get '/projects/new' do
        redirect_if_not_logged_in
        erb :'/projects/new'
    end

    #create action
    post '/projects' do
        #binding.pry
        @project = current_user.projects.create(params)
        if @project.errors
            #binding.pry
            
            erb :'/projects/new'
        else
            redirect "/projects/#{project.id}"
        end
    end

    #show action
    get '/projects/:id' do
        redirect_if_not_logged_in
        if set_project
            erb :'projects/show'
        else
            @error = "That project doesn't exist."
            erb :'projects/index'
        end
    end

    #edit action(view for form that will update)
    get '/projects/:id/edit' do
        redirect_if_not_logged_in
        if set_project
            erb :'projects/edit'
        else
            session[:error2] = "That project doesn't exist."
            redirect '/projects'
        end
    end

    #update action
    patch '/projects/:id' do
        params.delete(:_method)
        set_project
        @project.update(params)
        redirect '/projects'
    end

    #delete action
    delete '/projects/:id' do
        set_project
        @project.destroy
        redirect '/projects'
    end

    private
    def set_project
        @project = current_user.projects.find_by_id(params[:id])
    end
end
