class TodosController < ApplicationController
	def index             
              if params[:done].blank?
                    @todos=Todo.all
              end
              if params[:done].present?
                    @todos=Todo.where(:done => true)
              end

              if params[:donnotdone].present?
                    @todos=Todo.where(:done => false)
              end 

              #todos.where(params[:done]=='false')
                    
  	end

      def search
             if params[:done].present?
                    @todos = @todos.where("done like ?","%#{params[:done]}%")
            end      
        
      end

  	def show
    		@todo = Todo.find(params[:id])
  	end

  	def new
    		@todo = Todo.new
  	end

  	def create
  		@todo=Todo.new(todo_params)
  		if @todo.save
  			redirect_to root_path
  		else
  			render :new
  		end
  	end
  	
  	def edit
  		@todo=Todo.find(params[:id])
  	end

       def destroy
            @todo=Todo.find(params[:id])
            @todo.destroy
            redirect_to todos_path        
      end

  	def update
		@todo=Todo.find(params[:id])
		if @todo.update(todo_params)
			redirect_to root_path
		else
			render :edit
		end
		
	end

  	def finish
   		@todo = Todo.find(params[:id])
    		if @todo.done == false
      			@todo.update_attributes(done: true)
      			redirect_to(root_path)
    		else
      			@todo.update_attributes(done: false)
      			redirect_to(root_path)
		end
  
	end

	private
	def todo_params
		params.require(:todo).permit(:topic ,:done)
		
	end
end
