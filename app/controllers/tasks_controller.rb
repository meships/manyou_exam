class TasksController < ApplicationController

  def index
    @tasks =current_user.tasks.page(params[:page]).per(3)
      if params[:sort_limit]
        @tasks = @tasks.sort_limit.page(params[:page]).per(3)
      elsif params[:sort_priority]
        @tasks = @tasks.sort_priority.page(params[:page]).per(3)
      else
        @tasks =current_user.tasks.order(created_at: :desc).page(params[:page]).per(3)
      end

      @search = params[:search]
      if @search.present?
        if @search[:title].present? && @search[:status].present?
          @tasks = @tasks.search_status(params[:search][:status])
          @tasks = @tasks.search_title(params[:search][:title])
        elsif @search[:title].present?
          @tasks = @tasks.search_title(params[:search][:title])
        elsif @search[:status].present?
          @tasks = @tasks.search_status(params[:search][:status])
        end
     end
  end

  #  helper_method :sort_column, :sort_direction
  #  def index
  #    @tasks = Task.order("#{sort_column} #{sort_direction}")
  #      if params[:title].present?
  #        @tasks = @tasks.search_title params[:title]
  #      end
  #      if params[:status].present?
  #        @tasks = @tasks.search_status params[:status]
  #      end
  #  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:content, :title, :limit, :status, :priority, :user_id)
  end

  # def sort_direction
  #   %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc' 
  # end
    
  # def sort_column 
  #   Task.column_names.include?(params[:sort]) ? params[:sort] : 'id' 
  # end
end
