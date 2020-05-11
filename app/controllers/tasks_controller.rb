class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.page(params[:page]).per(10).ransack(params[:q])
    @tasks = @q.result
    @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] })
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    # buildはnewのalias、紐付けた時はbuildにするのが慣習らしい
    if @task.save
      redirect_to tasks_path, success: "タスク「#{@task.name}」を登録しました。"
    else
      flash.now[:danger] = "タスクの登録に失敗しました。"
      render :new
    end

  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), success: "タスク「#{@task.name}」を更新しました。"
    else
      flash.now[:danger] = "タスクの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @task.destroy! # 例外にするべきか悩んだ
    redirect_to tasks_path, danger: 'タスクを削除しました'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :limit, :status, :priority, {label_ids: []})
    # TODO: パラメーターは後で追加する
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
