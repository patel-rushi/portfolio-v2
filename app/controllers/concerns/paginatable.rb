module Paginatable
  extend ActiveSupport::Concern

  PER_PAGE = 50

  private

  # `?p=` is used because the diary already uses `?page=` for its category.
  def paginate(scope, per_page: PER_PAGE)
    @total_pages = [(scope.count.to_f / per_page).ceil, 1].max
    @current_page = requested_page(scope, per_page).clamp(1, @total_pages)
    scope.limit(per_page).offset((@current_page - 1) * per_page)
  end

  def requested_page(scope, per_page)
    return params[:p].to_s.to_i if params[:p].present?

    # Deep links (?post=ID) land on the page that contains that post.
    if params[:post].present? && (index = scope.pluck(:id).index(params[:post].to_s.to_i))
      return index / per_page + 1
    end

    1
  end
end
