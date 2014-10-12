class MetricsController < ApplicationController
  def show
    respond_with metric
  end

  def index
    respond_with metrics, serializer: PageSerializer
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
    respond_with metric.destroy
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

  def metrics
    user.metrics.search(search_params).page(page).per(per).records
  end

  def page
    params[:page] || 1
  end

  def per
    params[:per] || 15
  end

  def search_params
    {}.tap do |search|
      search[:sort] = { updated_at: { order: :desc } }
      search[:query] =
        if params[:query].present?
          { fuzzy: { name: params[:query] } }
        else
          { match_all: { } }
        end
      search[:filter] = { term: { user_id: user.id } }
    end
  end

  def metric_params
    params.require(:metric).permit(:name, :value)
  end

  def metric_url(metric)
    user_metric_path(user, metric)
  end
end
