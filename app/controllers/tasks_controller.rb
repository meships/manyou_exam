class TasksController < ApplicationController

     def index
       @tasks = Task.all.order(created_at: :desc)

         if params[:title].present?
           @tasks = @tasks.search_title params[:title]
         end
         if params[:status].present?
           @tasks = @tasks.search_status params[:status]
        end
    end

   #def index
     #@tasks = Task.all.order(created_at: :desc)

       #if params[:search].present?
          # if params[:search][:status].present? && params[:search][:title].present?
             #@tasks =  @tasks.search_title (params[:search][:title])
             #@tasks =  @tasks.search_status (params[:search][:status])
       #end
       #if params[:title].present?
          # elsif params[:search][:title].present?
             #@tasks = @tasks.search_title (params[:title])
          # elsif params[:search][:status].present?
          #   @tasks = @tasks.search_status (params[:search][:status])
          #end
       #end
   #end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "タスクを作成しました"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "タスクを編集しました"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:notice] = "タスクを削除しました"
      redirect_to tasks_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:content, :title, :limit, :status, :priority)
  end

end
