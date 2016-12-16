module Api
  class TodosController < ApplicationController

    def index
      @todos = Todo.all.order("completed ASC").order("id DESC")
      render json: @todos
    end

    def show
      @todo = Todo.find(params[:id])
      render json: @todo
    end

    def new
      @todo = Todo.new
    end 
    
    def edit
    end 

    def create
      @todo = Todo.new(todo_params)
      if @todo.save
        render :json => @todo, status: 201
      else 
        render :json => { errors: @todo.errors.messages }, status: 422
      end
    end

    def update
      @todo = Todo.find(params[:id])
      if @todo.update(todo_params)
        render :json => @todo, status: 201
      else
        render :json => { errors: @todo.errors.messages }, status: 422
      end  
    end

    def destroy
      @todo = Todo.destroy(params[:id])
      if @todo.destroy
        render :json => { :head => "ok" }
      else 
        render :json => { errors: @todo.errors.messages}, status: 422
      end 
    end  


    private

    def todo_params
      params.require(:todo).permit(:title, :completed)
    end

  end
end 

