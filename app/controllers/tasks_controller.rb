class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task.create(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスク「#{@task.name}」を登録しました。"
    else
      flash.now[:danger] = "タスクの登録に失敗しました。"
      render :new
    end

  end

  def edit

  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
    # TODO: パラメーターは後で追加する
  end
end
