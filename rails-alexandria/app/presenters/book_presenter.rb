class BookPresenter < BasePresenter
  build_with    :id, :title, :subtitle, :isbn_10, :isbn_13, :description,
                :released_on, :publisher_id, :author_id, :created_at,
                :updated_at, :cover

  sort_by       :id, :title, :released_on, :created_at, :updated_at

  filter_by     :id, :title, :released_on, :created_at, :updated_at

  related_to    :author, :publisher

  def cover
    @object.cover.url.to_s
  end
end