class Users::MetricsController < ApplicationController
  def show
    respond_with metric
  end

  def index
    respond_with user.metrics
  end

  def create
    metric = Metric.new(metric_params.merge(user: user))
    authorize metric

    respond_with user.metrics.create(metric.attributes)
  end

  def update
    respond_with metric.update(metric_params)
  end

  def destroy
    respond_with metric.delete
  end

  protected

  def user
    User.friendly.find(params[:user_id])
  end

  def metric
    Metric.find(params[:id]).tap do |metric|
      authorize metric
    end
  end

  def metric_params
    params.require(:metric).permit(:name, :value)
  end

  def metric_url(metric)
    user_metric_path(user, metric)
  end
end
